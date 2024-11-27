package gdscompiler;

import reflaxe.helpers.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

import reflaxe.BaseCompiler;
import reflaxe.data.ClassFuncData;
import reflaxe.preprocessors.BasePreprocessor;


@:using(gdscompiler.GDShaderContext.GDShaderContextValueHelper)
enum GDShaderContextValue {
	Undefined;
	Boolean(v: Bool);
	Integer(v: Int);
	Identifier(name: String);
}

class GDShaderContextValueHelper {
	public static function from(expression: Expr): GDShaderContextValue {
		return switch(expression) {
			case { expr: EConst(CIdent(identifier)) }: {
				if(identifier == "true") Boolean(true);
				else if(identifier == "false") Boolean(false);
				else Identifier(identifier);
			}
			case { expr: EConst(CInt(number, _)) }: {
				final int = Std.parseInt(number);
				if(int != null) Integer(int);
				else Context.error("Invalid integer.", expression.pos);
			}
			case _: Context.error("Invalid value.", expression.pos);
		}
	}

	public static function equals(self: GDShaderContextValue, other: GDShaderContextValue): Bool {
		return switch([self, other]) {
			case [Undefined, Undefined]: true;
			case [Boolean(v), Boolean(v2)]: v == v2;
			case [Integer(v), Integer(v2)]: v == v2;
			case [Identifier(v), Identifier(v2)]: v == v2;
			case _: false;
		}
	}
}

class GDShaderContext extends BasePreprocessor {
	var values: Map<String, GDShaderContextValue>;

	public function new() {
		values = [];
	}

	public function process(data: ClassFuncData, compiler: BaseCompiler): Void {
		if(data.expr == null) {
			return;
		}
		data.setExpr(filterConstIfs(data.expr));
	}

	function filterConstIfs(expr: TypedExpr) {
		switch(expr.expr) {
			case TMeta({ name: ":constif", params: params, pos: pos }, e1): {
				if(params != null && params.length == 1) {
					if(!evalBool(params[0])) {
						return { expr: TBlock([]), pos: pos, t: expr.t };
					} else {
						return haxe.macro.TypedExprTools.map(e1, filterConstIfs);
					}
				} else {
					Context.error("@:constif must have one parameter.", pos);
				}
			}
			case _:
		}

		return haxe.macro.TypedExprTools.map(expr, filterConstIfs);
	}

	public function reset() {
		values = [];
	}

	public function addAssignment(expression: Expr) {
		switch(expression) {
			case macro $key = $value: {
				final ident = switch(key) {
					case { expr: EConst(CIdent(identifier)) }: identifier;
					case _: Context.error("Expected identifier.", key.pos);
				}

				values.set(ident, GDShaderContextValueHelper.from(value));
			}
			case _: Context.error("Not an assignment.", expression.pos);
		}
	}

	public function evalBool(expression: Expr): Bool {
		return switch(eval(expression)) {
			case Boolean(v): v;
			case _: Context.error("Does not evaluate to boolean.", expression.pos);
		}
	}

	public function eval(expression: Expr): GDShaderContextValue {
		return switch(expression) {
			case macro $left == $right: {
				Boolean(eval(left).equals(eval(right)));
			}
			case macro $left != $right: {
				Boolean(!eval(left).equals(eval(right)));
			}
			case macro $left && $right: {
				Boolean(evalBool(left) && evalBool(right));
			}
			case macro $left || $right: {
				Boolean(evalBool(left) || evalBool(right));
			}
			case macro !$v: {
				Boolean(!evalBool(v));
			}
			case macro ($v): {
				eval(v);
			}
			case { expr: EConst(CIdent(ident)) }: {
				values.get(ident) ?? Identifier(ident);
			}
			case { expr: EConst(_) }: {
				GDShaderContextValueHelper.from(expression);
			}
			case _: {
				Context.error("Could not parse expression.", expression.pos);
			}
		}
	}
}
