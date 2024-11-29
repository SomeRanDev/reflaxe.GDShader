package gdscompiler;

#if (macro || gdshader_runtime)

//import haxe.macro.Context;
import reflaxe.helpers.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

import reflaxe.data.ClassVarData;
import reflaxe.data.ClassFuncData;
import reflaxe.data.EnumOptionData;

import reflaxe.DirectToStringCompiler;
import reflaxe.preprocessors.implementations.everything_is_expr.EverythingIsExprSanitizer;

using StringTools;

using reflaxe.helpers.ArrayHelper;
using reflaxe.helpers.BaseTypeHelper;
using reflaxe.helpers.ClassFieldHelper;
using reflaxe.helpers.ModuleTypeHelper;
using reflaxe.helpers.NameMetaHelper;
using reflaxe.helpers.NullableMetaAccessHelper;
using reflaxe.helpers.NullHelper;
using reflaxe.helpers.OperatorHelper;
using reflaxe.helpers.StringBufHelper;
using reflaxe.helpers.SyntaxHelper;
using reflaxe.helpers.TypedExprHelper;
using reflaxe.helpers.TypeHelper;

using gdscompiler.helpers.StringArray;
using gdscompiler.helpers.TypedExprHelper;

class GDShaderCompiler extends reflaxe.DirectToStringCompiler {
	var includes: Array<String> = [];
	var functions: Array<ClassFuncData> = [];
	var generatedFunctions: Map<String, Bool> = [];
	var context = new GDShaderContext();
	var nameOverrides: Map<Int, String> = [];

	public function new() {
		super();
	}

	override function formatExpressionLine(expr: String): String {
		if(expr.endsWith("}")) {
			return expr;
		}
		if(expr.trim().length == 0) {
			return expr;
		}
		return expr + ";";
	}

	function compileType(type: Type, pos: Position): String {
		if(type.isVoid()) {
			return "void";
		}

		final prim = switch(type) {
			case TAbstract(_.get() => { name: "Int", pack: [] }, []): "int";
			case TAbstract(_.get() => { name: "Float", pack: [] }, []): "float";
			case TAbstract(_.get() => { name: "Bool", pack: [] }, []): "bool";
			case TAbstract(_.get() => { name: "UInt", pack: [] }, []): "uint";
			case _: null;
		}
		if(prim != null) {
			return prim;
		}

		final meta = type.getMeta();
		if(meta != null) {
			final gdshaderTypeName = meta.extractStringFromFirstMeta(":gdshaderType");
			if(gdshaderTypeName != null) {
				return gdshaderTypeName;
			}
		}

		Context.error(type + " is not supported by Reflaxe/GDShader", pos);
		return "";
	}

	public function compileClassImpl(classType: ClassType, varFields: Array<ClassVarData>, funcFields: Array<ClassFuncData>): Null<String> {
		final shaderType = switch(classType.superClass) {
			case { t: _.get() => classType }: {
				final metas = classType.meta.maybeExtract(":shaderType");
				switch(metas) {
					case [{ params: [{ expr: EConst(CIdent(v)) }] }]: v;
					case _: null;
				}
			}
			case _: null;
		}

		// final isShader = switch(classType.superClass) {
		// 	case { t: _.get() => { name: "Shader", pack: ["gdshader"] }, params: [] }: true;
		// 	case _: false;
		// }

		for(shader in classType.meta.maybeExtract(":shader")) {
			final params = shader.params ?? [];

			final path = switch(params[0]) {
				case { expr: EConst(CString(path, _)) }: path;
				case _: Context.error("@:shader(path: String, ...(key = value)) has incorrect parameters!", shader.pos);
			}

			var startIndex = 1;
			final renderModes = if(params.length > 1) {
				switch(params[1]) {
					case { expr: ECall(macro RenderMode, identifiers) }: {
						startIndex = 2;
						identifiers.map(ident -> switch(ident) {
							case { expr: EConst(CIdent(ident)) }: ident;
							case _: null;
						});
					}
					case _: null;
				}
			} else null;

			context.reset();
			for(i in startIndex...params.length) {
				context.addAssignment(params[i]);
			}

			compileClassImpl2(shaderType, renderModes, path, classType, varFields, funcFields);
		}

		return null;
	}

	function compileClassImpl2(
		shaderType: Null<String>, renderModes: Null<Array<String>>, path: String,
		classType: ClassType, varFields: Array<ClassVarData>, funcFields: Array<ClassFuncData>
	): Void {
		// reset class compile state
		includes = [];
		functions = [];
		generatedFunctions = [];

		// instance vars
		final varsContent = new StringBuf();
		for(v in varFields) {
			final field = v.field;

			if(field.isExtern || field.hasMeta(":extern") || field.hasMeta(":gds_extern")) {
				continue;
			}

			var shouldCompile = true;
			for(condition in field.meta.maybeExtract(":constif")) {
				final cond = switch(condition.params) {
					case [expression]: context.evalBool(expression);
					case _: Context.error("@:constif must contain a single expression parameter.", condition.pos);
				}
				if(!cond) {
					shouldCompile = false;
					break;
				}
			}

			if(!shouldCompile) {
				continue;
			}

			if(field.hasMeta(":varying")) {
				varsContent.add("varying ");
			} else if(field.hasMeta(":global")) {
				varsContent.add("global uniform ");
			} else {
				varsContent.add("uniform ");
			}
			varsContent.add(compileType(field.type, field.pos));
			varsContent.add(" ");
			varsContent.add(compileVarName(field.name, null, field));

			final attributes = [];
			if(field.hasMeta(":color")) {
				attributes.push("source_color");
			}
			if(field.hasMeta(":range")) {
				// TODO: Add param checker function in Reflaxe to ensure 2-3 Float params.
				final params = field.meta.extractParamsFromFirstMeta(":range");
				if(params != null) {
					attributes.push("hint_range(" + params.join(", ") + ")");
				}
			}

			if(attributes.length > 0) {
				varsContent.add(": ");
				varsContent.add(attributes.join(", "));
			}

			final expr = v.findDefaultExpr();
			if(expr != null && !expr.isNoInitCall()) {
				varsContent.add(" = ");
				varsContent.add(compileExpression(expr));
			}
			varsContent.add(";\n");
		}

		// class functions
		final funcContent = new StringBuf();
		for(f in funcFields) {
			final field = f.field;

			if(field.isExtern || field.hasMeta(":extern") || field.hasMeta(":gds_extern")) {
				continue;
			}

			// GDShader doesn't use constructors.
			if(field.name == "new") {
				continue;
			}

			// Filter out false `@:constif`s, then reapply preprocessors.
			final f = f.clone();
			f.applyPreprocessors(this, [
				Custom(context),
				RemoveSingleExpressionBlocks,
				RemoveConstantBoolIfs,
				RemoveUnnecessaryBlocks,
				RemoveReassignedVariableDeclarations,
				RemoveLocalVariableAliases,
			]);

			funcContent.add(compileType(f.ret, field.pos));
			funcContent.add(" ");
			funcContent.add(compileVarName(field.name, null, field));
			funcContent.add("(");
			var doComma = false;
			for(arg in f.args) {
				if(doComma) funcContent.add(", ");
				else doComma = true;
				funcContent.add(compileType(arg.type, field.pos));
				funcContent.add(" ");
				funcContent.add(compileVarName(arg.getName()));
			}
			funcContent.add(")");
			if(f.expr != null) {
				funcContent.add(" ");
				funcContent.add(compileExpression(f.expr.ensureBlock()));
			}
			funcContent.add("\n");
		}

		final extraFuncContent = new StringBuf();
		final extraReservedNames = functions.length > 0 ? varFields.map(v -> v.field.name) : [];
		while(functions.length > 0) {
			final f = functions.splice(0, 1)[0];
			final field = f.field;

			if(field.isExtern || f.classType.isExtern || field.hasMeta(":extern") || field.hasMeta(":gds_extern")) {
				continue;
			}

			if(f.expr == null) {
				continue;
			}

			// Filter out false `@:constif`s, then reapply preprocessors.
			final f = f.clone();
			f.applyPreprocessors(this, [
				SanitizeEverythingIsExpression({}),
				PreventRepeatVariables({ extraReservedNames: extraReservedNames }),
				RemoveTemporaryVariables(AllTempVariables),
				Custom(context),
				RemoveSingleExpressionBlocks,
				RemoveConstantBoolIfs,
				RemoveUnnecessaryBlocks,
				RemoveReassignedVariableDeclarations,
				RemoveLocalVariableAliases,
			]);

			extraFuncContent.add(compileType(f.ret, field.pos));
			extraFuncContent.add(" ");
			extraFuncContent.add(compileVarName(field.name, null, field));
			extraFuncContent.add("(");
			var doComma = false;
			for(arg in f.args) {
				if(doComma) extraFuncContent.add(", ");
				else doComma = true;
				extraFuncContent.add(compileType(arg.type, field.pos));
				extraFuncContent.add(" ");
				extraFuncContent.add(compileVarName(arg.getName()));
			}
			extraFuncContent.add(")");
			if(f.expr != null) {
				extraFuncContent.add(" ");
				extraFuncContent.add(compileExpression(f.expr.ensureBlock()));
			}
			extraFuncContent.add("\n");
		}

		// Get list of compiled sections
		final combinedContent = [];
		combinedContent.pushIfNotEmpty(varsContent.toString().trim());
		combinedContent.pushIfNotEmpty(extraFuncContent.toString().trim());
		combinedContent.pushIfNotEmpty(funcContent.toString().trim());

		// Generate file
		if(combinedContent.length > 0) {
			final fileContent = new StringBuf();

			if(shaderType != null) {
				fileContent.addMulti("shader_type ", shaderType, ";\n\n");
			}

			if(renderModes != null) {
				fileContent.addMulti("render_mode ", renderModes.join(", "), ";\n\n");
			}

			if(includes.length > 0) {
				for(include in includes) {
					fileContent.addMulti("#include \"", include, "\"\n");
				}
				fileContent.add("\n");
			}

			fileContent.add(combinedContent.join("\n\n"));

			setExtraFile(path + ".gdshader", fileContent.toString());
		}
	}

	public function compileEnumImpl(enumType: EnumType, options:Array<EnumOptionData>): Null<String> {
		return null;
	}

	public function compileExpressionImpl(expr: TypedExpr, isTopLevel: Bool): Null<String> {
		var result = new StringBuf();
		switch(expr.expr) {
			case TConst(constant): {
				result.add(constantToGDShader(constant, expr.pos));
			}
			case TLocal(v): {
				result.add(compileVarName(v.name, expr));
			}
			case TIdent(s): {
				result.add(compileVarName(s, expr));
			}
			case TArray(e1, e2): {
				result.addMulti(compileExpressionOrError(e1), "[", compileExpressionOrError(e2), "]");
			}
			case TBinop(op, e1, e2): {
				result.add(binopToGDShader(op, e1, e2));
			}
			case TField(e, fa): {
				result.add(fieldAccessToGDShader(e, fa));
			}
			case TTypeExpr(m): {
				result.add(compileType(TypeHelper.fromModuleType(m), expr.pos));
			}
			case TParenthesis(e): {
				final gdScript = compileExpressionOrError(e);
				final expr = if(!EverythingIsExprSanitizer.isBlocklikeExpr(e)) {
					"(" + gdScript + ")";
				} else {
					gdScript;
				}
				result.add(expr);
			}
			case TObjectDecl(fields): {
				result.add("{\n");
				for(i in 0...fields.length) {
					final field = fields[i];
					result.addMulti("\t\"", field.name, "\": ");
					result.add(compileExpression(field.expr));
					if(i < fields.length - 1) {
						result.add(",");
					}
					result.add("\n"); 
				}
				result.add("}");
			}
			case TArrayDecl(el): {
				result.add("[");
				result.add(el.map(e -> compileExpression(e)).join(", "));
				result.add("]");
			}
			case TCall(e, el): {
				result.add(callToGDShader(e, el, expr));
			}
			case TNew(classTypeRef, params, el): {
				result.add(compileType(TInst(classTypeRef, params), expr.pos));
				result.add("(");
				result.add(el.map(e -> compileExpression(e)).join(", "));
				result.add(")");
			}
			case TUnop(op, postFix, e): {
				result.add(unopToGDShader(op, e, postFix));
			}
			case TFunction(_): {
				Context.error("Cannot compile lambdas in Reflaxe/GDShader", expr.pos);
			}
			case TVar(tvar, maybeExpr): {
				result.add(compileType(tvar.t, expr.pos));
				result.add(" ");
				result.add(compileVarName(tvar.name, expr));

				if(maybeExpr != null && !maybeExpr.isNoInitCall()) {
					final e = compileExpressionOrError(maybeExpr);
					result.addMulti(" = ", e);
				}
			}
			case TBlock(el): {
				result.add("{\n");

				if(el.length > 0) {
					result.add(toIndentedScope(expr));
				}

				result.add("\n}");
			}
			case TFor(tvar, iterExpr, blockExpr): {
				result.addMulti(
					"for ", tvar.name, " in ", compileExpressionOrError(iterExpr), ":\n"
				);
				result.add(toIndentedScope(blockExpr));
			}
			case TIf(econd, ifExpr, elseExpr): {
				result.addMulti("if(", compileExpressionWithoutParenthesis(econd), ") {\n");
				result.add(toIndentedScope(ifExpr));

				// Precompile else to see if anything is generated.
				// @:constif statements might cause nothing to compile.
				final exprExprString = if(elseExpr != null) {
					toIndentedScope(elseExpr);
				} else {
					null;
				}
				if(exprExprString != null && exprExprString.trim().length > 0) {
					result.add("\n");
					result.add("} else {\n");
					result.add(exprExprString);
					result.add("\n}");
				} else {
					result.add("\n}");
				}
			}
			case TWhile(econd, blockExpr, normalWhile): {
				final gdCond = compileExpressionWithoutParenthesis(econd);
				if(normalWhile) {
					result.addMulti("while(", gdCond, ") {\n");
					result.add(toIndentedScope(blockExpr));
					result.add("\n}");
				} else {
					result.add("while(true) {\n");
					result.add(toIndentedScope(blockExpr));
					result.addMulti("\tif(", gdCond, ") {\n");
					result.add("\t\tbreak;\n");
					result.add("\t}\n");
					result.add("}");
				}
			}
			case TSwitch(e, cases, edef): {
				// Check if this is a switch on an extern enum...
				final externEnumType = switch(e.unwrapParenthesis().expr) {
					case TEnumIndex(e1): {
						switch(e1.t) {
							case TEnum(_.get() => e, _) if(e.isReflaxeExtern()): e;
							case _: null;
						}
					}
					case _: null;
				}

				result.addMulti("switch(", compileExpressionOrError(e), ") {");
				for(c in cases) {
					result.add("\n\t");
					result.add(c.values.map(function(v: TypedExpr) {
						return "case " + compileExpressionOrError(v) + ":";
					}).join("\n"));
					result.add(toIndentedScope(c.expr).tab());
				}
				if(edef != null) {
					result.add("\n\tdefault:\n");
					result.add(toIndentedScope(edef).tab());
				}
			}
			case TTry(_, _): {
				Context.error("Cannot use try/catch expressions in Reflaxe/GDShader", expr.pos);
			}
			case TReturn(maybeExpr): {
				result.add("return");
				if(maybeExpr != null) {
					result.add(" ");
					result.add(compileExpression(maybeExpr));
				}
			}
			case TBreak: {
				result.add("break");
			}
			case TContinue: {
				result.add("continue");
			}
			case TThrow(_): {
				Context.error("Cannot throw in Reflaxe/GDShader", expr.pos);
			}
			case TCast(expr, maybeModuleType): {
				final hasModuleType = maybeModuleType != null;
				final e = compileExpressionOrError(expr);
				if(!hasModuleType) {
					result.add(e);
				} else {
					final typeCode = compileType(TypeHelper.fromModuleType(maybeModuleType.trustMe()), expr.pos);
					result.addMulti(typeCode, "(", e, ")");
				}
			}
			case TMeta(m, expr): {
				var shouldCompile = true;
				var printMeta = true;
				// if(m.name == ":constif") {
				// 	if(m.params != null && m.params.length == 1) {
				// 		if(!context.evalBool(m.params[0])) {
				// 			shouldCompile = false;
				// 		} else {
				// 			printMeta = false; // Do not print as @:constif is "consumed".
				// 		}
				// 	} else {
				// 		Context.error("@:constif must contain a single expression parameter.", m.pos);
				// 	}
				// }

				if(shouldCompile) {
					switch(m) {
						case { name: ":const" } if(m.params == null || m.params.length == 0): {
							switch(expr.unwrapMeta().expr) {
								case TVar(_, _): {
									result.addMulti("const ", compileExpressionOrError(expr));
								}
								case _: {
									Context.error("@:const can only be used on variables.", m.pos);
								}
							}
						}
						case _: {
							if(printMeta) {
								result.addMulti("/* @", m.name, " */ ");
							}
							result.add(compileExpressionOrError(expr));
						}
					}
				}
			}
			case TEnumParameter(expr, enumField, index): {
				result.add(compileExpressionOrError(expr));
				switch(enumField.type) {
					case TFun(args, _): {
						if(index < args.length) {
							result.addMulti(".", args[index].name);
						}
					}
					case _:
				}
			}
			case TEnumIndex(expr): {
				final isExtern = switch(expr.t) {
					case TEnum(_.get() => e, _): e.isReflaxeExtern();
					case _: false;
				}

				if(isExtern) {
					result.add("((");
				}
				result.add(compileExpressionOrError(expr));
				if(isExtern) {
					result.add(" as Variant) as int)");
				} else {
					result.add("._index");
				}
			}
		}
		return result.toString();
	}

	function toIndentedScope(e: TypedExpr): String {
		var el = switch(e.expr) {
			case TBlock(el): el;
			case _: [e];
		}

		return if(el.length == 0) {
			"";
		} else {
			compileExpressionsIntoLines(el).tab();
		}
	}

	function compileExpressionWithoutParenthesis(expr: TypedExpr) {
		return compileExpressionOrError(expr.unwrapParenthesis());
	}

	function constantToGDShader(constant: TConstant, pos: Position): String {
		return switch(constant) {
			case TInt(i): Std.string(i);
			case TFloat(s): s;
			case TString(s): "\"" + StringTools.replace(StringTools.replace(s, "\\", "\\\\"), "\"", "\\\"") + "\"";
			case TBool(b): b ? "true" : "false";
			case TNull: Context.error("Cannot compile null in Reflaxe/GDShader", pos);
			case TThis: "this";
			case TSuper: Context.error("Cannot compile super in Reflaxe/GDShader", pos);
			case _: "";
		}
	}

	function binopToGDShader(op: Binop, e1: TypedExpr, e2: TypedExpr): String {
		var gdExpr1 = compileExpression(e1);
		var gdExpr2 = compileExpression(e2);
		final operatorStr = OperatorHelper.binopToString(op);
		return gdExpr1 + " " + operatorStr + " " + gdExpr2;
	}

	function callToGDShader(calledExpr: TypedExpr, arguments: Array<TypedExpr>, originalExpr: TypedExpr): StringBuf {
		// Check @:nativeTypeCode
		var nfcTypes = null;
		final originalExprType = originalExpr.t;
		final nfc = this.compileNativeFunctionCodeMeta(calledExpr, arguments, function(index: Int) {
			if(nfcTypes == null) nfcTypes = calledExpr.getFunctionTypeParams(originalExprType);
			if(nfcTypes != null && index >= 0 && index < nfcTypes.length) {
				return compileType(nfcTypes[index], calledExpr.pos);
			}
			return null;
		});

		if(nfc != null) {
			final result = new StringBuf();
			result.add(nfc);
			return result;
		}

		/*includes*/
		{
			final declaration = calledExpr.getDeclarationMeta(arguments);
			if(declaration != null) {
				final meta = declaration.meta;
				final data = meta != null ? extractStringFromMeta(meta, ":include") : null;
				if(data != null) {
					final code = data.code.trim();
					if(!includes.contains(code)) {
						includes.push(code);
					}
				}
			}
		}

		switch(calledExpr) {
			case { expr: TField({ expr: TTypeExpr(m) }, FStatic(_.get() => cls, _.get() => field)) }: {
				if(getCurrentModule() != m) {
					final data = field.findFuncData(cls, true);
					if(!generatedFunctions.exists(data.id)) {
						generatedFunctions.set(data.id, true);
						functions.push(data);
					}
				}
			}
			case _:
		}

		final result = new StringBuf();
		
		result.add(compileExpression(calledExpr));
		result.add("(");
		result.add(arguments.map(e -> compileExpressionOrError(e)).join(", "));
		result.add(")");

		return result;
	}

	function unopToGDShader(op: Unop, e: TypedExpr, isPostfix: Bool): String {
		final gdExpr = compileExpressionOrError(e);
		final operatorStr = OperatorHelper.unopToString(op);
		return isPostfix ? (gdExpr + operatorStr) : (operatorStr + gdExpr);
	}

	function fieldAccessToGDShader(e: TypedExpr, fa: FieldAccess): String {
		var isStatic = false;
		final nameMeta: NameAndMeta = switch(fa) {
			case FInstance(_, _, classFieldRef): classFieldRef.get();
			case FStatic(_, classFieldRef): {
				isStatic = true;
				classFieldRef.get();
			}
			case FAnon(classFieldRef): classFieldRef.get();
			case FClosure(_, classFieldRef): classFieldRef.get();
			case FEnum(_, enumField): enumField;
			case FDynamic(s): { name: s, meta: null };
		}

		return if(nameMeta.hasMeta(":native")) {
			nameMeta.getNameOrNative();
		} else {
			final name = compileVarName(nameMeta.getNameOrNativeName());

			// There is no static access in GDShader, just return the function/var name.
			if(isStatic) {
				return name;
			}

			// Avoid using `this.`, as class variables should be used directly.
			if(e.isThisExpr()) {
				return name;
			}

			final expr = compileExpression(e);
			return expr + "." + name;
		}
	}
}

#end
