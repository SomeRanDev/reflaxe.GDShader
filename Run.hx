/**
	Reflaxe/GDShader Run

	This generates the contents of the `api/` folder.
**/
import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;

using StringTools;

/**
	The structure of the JSON data from `shader_api.json`.
**/
typedef ShaderApi = {
	datatypes: Array<{
		name: String,
		indexing_return_type: String,
		size: Int,
		component_count: Int,
		indexing_size: Int,
		swizzle_field_count: Int,
		is_scalar: Bool,
		is_float: Bool,
		is_sampler: Bool,
		operators: Array<{
			name: String,
			return_type: String,
			?right_type: String,
		}>,
	}>,
	modes: Array<{
		name: String,
		render_modes: Array<{
			name: String,
			?options: Array<String>
		}>,
		stencil_modes: Array<{
			name: String,
			?options: Array<String>
		}>,
		stages: Array<{
			name: String,
			can_discard: Bool,
			main_function: Bool,
			built_ins: Array<{
				name: String,
				type: String,
				constant: Bool,
				?values: Array<Dynamic>,
			}>,
			stage_functions: Array<{
				name: String,
				arguments: Array<{
					name: String,
					type: String,
				}>,
				return_type: String,
				skip_function: String,
			}>,
		}>,
	}>,
	functions: Array<{
		name: String,
		is_frag_only: Bool,
		overloads: Array<{
			return_type: String,
			is_high_end: Bool,
			arguments: Array<{
				name: String,
				type: String,
				is_out: Bool,
				is_const: Bool,
				?min: Int,
				?max: Int,
			}>,
		}>,
	}>,
};

/**
	Creates a directory if it doesn't exist.
	If a file exists at the `dir` path, an error is printed to `stderr` and the process exists with `0`.
**/
function makeDirectory(dir: String) {
	if(!FileSystem.exists(dir)) {
		FileSystem.createDirectory(dir);
	} else if(!FileSystem.isDirectory(dir)) {
		Sys.stderr().writeString('$dir is not a directory');
		Sys.exit(1);
	}
}

/**
	Main.
**/
function main() {
	final args = Sys.args();
	if(args.remove("generate-api")) {
		generateApi(args);
		return;
	}

	switch(args) {
		case ["help", _]: {
			help();
		}
		case _: {
			Sys.println("** Invalid arguments. **\n");
			help();
		}
	}
}

/**
	Print help message.
**/
function help() {
	Sys.println("
===========================
* Reflaxe/GDShader Run Help
===========================

The run script for Reflaxe/GDShader.

----
Help
----

  Prints this message.

  haxelib run reflaxe.gdshader help

------------
Generate API
------------

  Generates the Haxe code for the Godot shader API given a `shader_api.json` file.

  haxelib run reflaxe.gdshader generate-api help
  haxelib run reflaxe.gdshader generate-api <output-directory> <json-path>

===========================
	".trim());
}

/**
	Generate the Godot Shader API.
**/
function generateApi(args: Array<String>) {
	var outputDir = "./gdshader-api";
	var jsonPath = "./shader_api.json";
	final cwd = switch(args) {
		case ["help", _]: {
			helpGenerateApi();
			return;
		}
		case [cwd]: {
			cwd;
		}
		case [outputDirArg, cwd]: {
			outputDir = outputDirArg;
			cwd;
		}
		case [outputDirArg, jsonPathArg, cwd]: {
			outputDir = outputDirArg;
			jsonPath = jsonPathArg;
			cwd;
		}
		case _: {
			Sys.println("** Invalid arguments. **\n");
			helpGenerateApi();
			return;
		}
	}

	if(cwd != null) {
		Sys.setCwd(cwd);
	}

	if(!FileSystem.exists(jsonPath)) {
		Sys.stderr().writeString('$jsonPath could not be found');
		Sys.exit(1);
	}

	makeDirectory(outputDir);

	final data: ShaderApi = try {
		final jsonString = File.getContent(jsonPath);
		final jsonData: ShaderApi = Json.parse(jsonString);
		jsonData;
	} catch(e) {
		Sys.stderr().writeString('$jsonPath could not be parsed');
		Sys.exit(1);
		return;
	}

	generateApiImpl(outputDir, data);
}

/**
	Print help message for bindings generation.
**/
function helpGenerateApi() {
	Sys.println("
======================================
* GDShader Bindings Generator for Haxe
======================================

This generates a lot of the standard library for Reflaxe/GDShader.

----------
How to run
----------

  haxelib run reflaxe.gdshader generate-api <output-directory> <json-path>

---------
Arguments
---------

<output-directory>

  The output directory of the GDShader std for Haxe.

  Default value: ./gdshader-api

<json-path>

  The input JSON data containing the Godot shader API.
  This can be generated from Godot by running: `godot --dump-shader-api`.

  Default value: ./shader_api.json

======================================
	".trim());
}

/**
	Converts an identifier in snake_case to PascalCase.
**/
function snakeToPascal(identifier: String): String {
    final result = identifier
		.split("_")
		.filter(s -> s.length > 0)
		.map(s -> s.substr(0,1).toUpperCase() + s.substr(1))
		.join("");

	return result
		.replace("2d", "2D")
		.replace("3d", "3D");
}

/**
	Converts type name from GDShader to what it should be in Haxe.
**/
function gdshaderTypeToHaxe(typeName: String): String {
	// The actual implementation of this function.
	function impl(typeName: String): String {
		return snakeToPascal(if(~/^[biu]/.match(typeName) && typeName != "int" && typeName != "bool") {
			typeName.substring(0, 1) + "_" + typeName.substring(1);
		} else {
			typeName;
		});
	}
	
	// Cache the result from `impl` since it a little expensive.
	static var cache: Map<String, String> = [];
	final result = cache.get(typeName);
	return if(result != null) {
		result;
	} else {
		final result = impl(typeName);
		cache.set(typeName, result);
		result;
	}
}

final XYZW = ["x", "y", "z", "w"];
final RGBA = ["r", "g", "b", "a"];
final STPQ = ["s", "t", "p", "q"];

final TYPE_VARIATIONS = [
	"bool" => ["bool", "bvec2", "bvec3", "bvec4"],
	"float" => ["float", "vec2", "vec3", "vec4"],
	"int" => ["int", "ivec2", "ivec3", "ivec4"],
	"uint" => ["uint", "uvec2", "uvec3", "uvec4"],
];

final OPERATOR_NAMES = [
	"==" => "equals", "!=" => "notEquals",
	"<" => "lessThan", "<=" => "lessThanOrEqual", ">" => "greaterThan", ">=" => "greaterThanOrEqual",
	"&&" => "boolAnd", "||" => "boolOr", "!" => "boolNot",
	"unary-" => "negate",
	"+" => "add", "-" => "subtract", "*" => "multiply", "/" => "divide", "%" => "modulus",
	"<<" => "shiftLeft", ">>" => "shiftRight",
	"=" => "assign", "+=" => "addAssign", "-=" => "subtractAssign", "*=" => "multiplyAssign", "/=" => "divideAssign", "%=" => "modulusAssign",
	"<<=" => "shiftLeftAssign", ">>=" => "shiftRightAssign", "&=" => "bitAndAssign", "|=" => "bitOrAssign", "^=" => "bitXOrAssign",
	"&" => "bitAnd", "|" => "bitOr", "^" => "bitXOr", "~" => "bitInvert",
	"++" => "increment", "--" => "decrement", "post++" => "postIncrement", "post--" => "postDecrement",
];

/**
	Generates all possible swizzle fields.

	`outFields` is an `Array` that the result is appended to.

	`swizzleFields` should be an `Array` of single-character identifiers with a length of at least `swizzleFieldCount`.
	These are a list of all the fields that will be swizzled.

	`typeVariations` is an `Array` of length `4` containing the four Haxe type names that should be provided given the
	number of swizzled fields. For example: `["Float", "Vec2", "Vec3", "Vec4"]`.

	`swizzleFieldCount` is the number of dimensions we should make swizzleable.
	For example, passing `2` will mean only `x` and `y` can be swizzled.
	The maximum allowed value is `4`.
**/
function generateSwizzleFields(outFields: Array<String>, swizzleFields: Array<String>, typeVariations: Array<String>, swizzleFieldCount: Int) {
	if(swizzleFieldCount < 2 || swizzleFieldCount > 4) {
		throw "swizzleFieldCount must be within range [2...4]";
	}
	
	for(i in 0...swizzleFieldCount) {
		outFields.push('var ${swizzleFields[i]}: ${typeVariations[0]};');
	}

	for(i in 0...swizzleFieldCount) {
		for(j in 0...swizzleFieldCount) {
			outFields.push('var ${swizzleFields[i] + swizzleFields[j]}: ${typeVariations[1]};');
		}
	}

	for(i in 0...swizzleFieldCount) {
		for(j in 0...swizzleFieldCount) {
			for(k in 0...swizzleFieldCount) {
				outFields.push('var ${swizzleFields[i] + swizzleFields[j] + swizzleFields[k]}: ${typeVariations[2]};');
			}
		}
	}

	for(i in 0...swizzleFieldCount) {
		for(j in 0...swizzleFieldCount) {
			for(k in 0...swizzleFieldCount) {
				for(l in 0...swizzleFieldCount) {
					outFields.push('var ${swizzleFields[i] + swizzleFields[j] + swizzleFields[k] + swizzleFields[l]}: ${typeVariations[3]};');
				}
			}
		}
	}
}

/**
	The arguments for type constructors do not have names, so let's make some up.
**/
function generateConstructorArgumentNames(arguments: Array<{ name:String, type:String }>): Array<String> {
	final names = [];
	final argumentCount = arguments.length;

	var uniqueArgumentTypeCount = 0;
	final argumentTypeCounts: Map<String, Int> = [];
	for(a in arguments) {
		if(!argumentTypeCounts.exists(a.type)) {
			argumentTypeCounts.set(a.type, 1);
			uniqueArgumentTypeCount++;
		} else {
			argumentTypeCounts.set(a.type, argumentTypeCounts.get(a.type) + 1);
		}
	}
	final allSameType = uniqueArgumentTypeCount == 1;
	final allDifferentTypes = uniqueArgumentTypeCount == argumentCount;

	final argumentTypeCounter: Map<String, Int> = [];
	for(i in 0...argumentCount) {
		final arg = arguments[i];
		final haxeTypeName = gdshaderTypeToHaxe(arg.type);
		final name = if(arg.name.length > 0) {
			arg.name;
		} else if(argumentCount > 1 && argumentCount <= 4 && allSameType) {
			XYZW[i];
		} else if(allDifferentTypes || argumentTypeCounts.get(arg.type) == 1) {
			haxeTypeName.toLowerCase();
		} else {
			final count = (argumentTypeCounter.get(arg.type) ?? 0) + 1;
			final result = haxeTypeName.toLowerCase() + count;
			argumentTypeCounter.set(arg.type, count);
			result;
		}
		names.push(name);
	}

	return names;
}

/**
	Stores operators from "bool", "int", "uint", and "float" in a map with the key being the operator's right type.
	This lets future types find operators that use a right type of themselves and a left of the primitive.
**/
function findBonusOperators(data: ShaderApi): Map<String, Array<{ name:String, return_type:String, left_type:String }>> {
	final result = new Map();
	for(datatype in data.datatypes) {
		switch(datatype.name) {
			case "bool" | "int" | "uint" | "float":
			case _: continue;
		}

		for(op in datatype.operators) {
			final rightType = op.right_type;
			if(rightType != null) {
				if(!result.exists(rightType)) {
					result.set(rightType, []);
				}
				result.get(rightType)?.push({
					name: op.name,
					return_type: op.return_type,
					left_type: datatype.name
				});
			}
		}
	}
	return result;
}

/**
	Generate the Reflaxe/GDShader API in `outputDir` given `data`.
**/
function generateApiImpl(outputDir: String, data: ShaderApi) {
	final gdshaderFolder = Path.join([outputDir, "gdshader"]);
	final modesFolder = Path.join([outputDir, "gdshader", "modes"]);
	final typesFolder = Path.join([outputDir, "gdshader", "types"]);
	makeDirectory(gdshaderFolder);
	makeDirectory(modesFolder);
	makeDirectory(typesFolder);

	final datatypeNames = [];

	final bonusOperators = findBonusOperators(data);

	final header = "package gdshader.types;\n\nimport gdshader.types.*;";
	for(datatype in data.datatypes) {
		final name = datatype.name;
		datatypeNames.push(name);

		switch(name) {
			case "bool" | "int" | "uint" | "float": continue;
			case _:
		}

		var constructorFunction = null;
		for(f in data.functions) {
			if(f.name == name) {
				constructorFunction = f;
				break;
			}
		}

		final haxeName = gdshaderTypeToHaxe(name);

		final fields = [];
		final swizzleFieldCount = datatype.swizzle_field_count;
		if(swizzleFieldCount > 0) {
			final typeVariations = TYPE_VARIATIONS[datatype.indexing_return_type].map(gdshaderTypeToHaxe);
			generateSwizzleFields(fields, XYZW, typeVariations, swizzleFieldCount);
			generateSwizzleFields(fields, RGBA, typeVariations, swizzleFieldCount);
			generateSwizzleFields(fields, STPQ, typeVariations, swizzleFieldCount);
		}

		final constructor = if(constructorFunction != null) {
			final argumentCodeList = constructorFunction.overloads
				.map(function(_overload) {
					final argumentCodes = [];
					final names = generateConstructorArgumentNames(_overload.arguments);
					for(i in 0..._overload.arguments.length) {
						final arg = _overload.arguments[i];
						final haxeTypeName = gdshaderTypeToHaxe(arg.type);
						argumentCodes.push('${names[i]}: $haxeTypeName');
					}
					return argumentCodes.join(", ");
				});
			final overloads = argumentCodeList.slice(1).map(a -> '@:overload(function($a): Void {})').join("\n\t");
			'\n\t$overloads\n\t@:native("${constructorFunction.name}")\n\tpublic function new(${argumentCodeList[0]});\n';
		} else {
			"";
		}

		function makeOperator(name: String, returnType: String, otherType: Null<String>, flip: Bool): Null<String> {
			final metadataOperation = switch(name) {
				case "=": return null; // assignment overloading not allowed in Haxe
				case "unary-": ["-A", "(-{0})"];
				case "post++": ["A++", "({0}++)"];
				case "post--": ["A--", "({0}--)"];
				case name if(otherType == null): ['${name}A', '($name{0})'];
				case name: ['A $name B', '({0} $name {1})'];
			}

			final functionArgs = ['me: $haxeName'];
			final functionArgNames = ["me"];
			if(otherType != null) {
				functionArgs.push('other: ${gdshaderTypeToHaxe(otherType)}');
				functionArgNames.push("other");
				if(flip) {
					functionArgs.push(functionArgs.shift());
					functionArgNames.push(functionArgNames.shift());
				}
			}

			final functionName = OPERATOR_NAMES[name] + (otherType != null ? gdshaderTypeToHaxe(otherType) : "") + (flip ? "Flipped" : "");
			return '@:op(${metadataOperation[0]}) public static inline function $functionName(${functionArgs.join(", ")}): ${gdshaderTypeToHaxe(returnType)} return untyped __gdshader__("${metadataOperation[1]}", ${functionArgNames.join(", ")});';
		}

		final operators = [];
		for(op in datatype.operators) {
			final code = makeOperator(op.name, op.return_type, op.right_type, false);
			if(code != null) operators.push(code);
		}
		for(op in bonusOperators.get(name) ?? []) {
			final code = makeOperator(op.name, op.return_type, op.left_type, true);
			if(code != null) operators.push(code);
		}

		final code = '$header

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("$name")
extern class ${haxeName}Inner {${fields.length > 0 ? '\n\t${fields.join("\n\t")}\n' : ""}}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("$name")
extern abstract $haxeName(${haxeName}Inner) {$constructor${operators.length > 0 ? '\n\t${operators.join("\n\t")}\n' : ""}}
';

		File.saveContent(Path.join([typesFolder, haxeName + ".hx"]), code);
	}

	final header = "package gdshader.modes;\n\nimport gdshader.types.*;";
	for(mode in data.modes) {
		final haxeModeName = snakeToPascal(mode.name);

		final stageNames: Map<String, Int> = new Map();
		var index = 0;
		for(s in mode.stages) {
			switch(s.name) {
				case "global" | "constants": continue;
				case name: stageNames.set(name, 1 << (index++));
			}
		}

		final isMutable: Map<String, Bool> = [];
		for(stage in mode.stages) {
			for(builtIn in stage.built_ins) {
				if(!builtIn.constant && !(isMutable.get(builtIn.name) ?? false)) {
					isMutable.set(builtIn.name, true);
				}
			}
		}

		final functions = [];
		final builtIns: Map<String, Array<String>> = [];
		for(stage in mode.stages) {
			final isStage = switch(stage.name) {
				case "global" | "constants": false;
				case name: {
					functions.push('public function $name(): Void;');
					true;
				}
			}

			for(builtIn in stage.built_ins) {
				final varCode = '${(isMutable.get(builtIn.name) ?? false) ? "var" : "final"} ${builtIn.name}: ${gdshaderTypeToHaxe(builtIn.type)}';
				if(!builtIns.exists(varCode)) {
					builtIns.set(varCode, []);
				}
				if(isStage) {
					builtIns.get(varCode)?.push(stage.name);
				}
			}
		}

		final builtIns = [for(code => stages in builtIns) {
			{
				code: '${stages.length > 0 ? '@:allowedStages(${stages.join(", ")}) ' : ""}$code;',
				stages: stages,
			}
		}];

		builtIns.sort(function(a, b) {
			function stageValues(stages): Int {
				return Lambda.fold(stages.map(s -> stageNames.get(s) ?? 0), (a: Int, b: Int) -> a + b, 0);
			}
			final stageLengthDiff = a.stages.length - b.stages.length;
			final stageDiff = stageValues(a.stages) - stageValues(b.stages);
			return if(a.stages.length == 0 && b.stages.length != 0) return -1;
			else if(a.stages.length != 0 && b.stages.length == 0) return 1;
			else if(stageDiff != 0) stageDiff;
			else if(a.code < b.code) -1;
			else if(a.code > b.code) 1;
			else 0;
		});

		final code = '$header

@:shaderType(${mode.name})
extern class $haxeModeName {
	${functions.join("\n\t")}

	${builtIns.map(b -> b.code).join("\n\t")}
}
';

		File.saveContent(Path.join([modesFolder, haxeModeName + ".hx"]), code);
	}

	final constructors = [];
	final functions = [];
	for(func in data.functions) {
		final multipleOverloads = func.overloads.length > 1;
		for(o in func.overloads) {
			final isConstructor = datatypeNames.contains(func.name);
			final names = if(isConstructor) {
				generateConstructorArgumentNames(o.arguments);
			} else {
				[
					for(i in 0...o.arguments.length) {
						final a = o.arguments[i];
						a.name.length == 0 ? '_$i' : a.name;
					}
				];
			}

			final arguments = [];
			for(i in 0...o.arguments.length) {
				final a = o.arguments[i];
				arguments.push('${names[i]}: ${gdshaderTypeToHaxe(a.type)}');
			}

			final keywords = ["extern", "function"];
			if(multipleOverloads) keywords.unshift("overload");

			final f = '${keywords.join(" ")} ${func.name}(${arguments.join(", ")}): ${gdshaderTypeToHaxe(o.return_type)};';
			if(isConstructor) {
				constructors.push(f);
			} else {
				functions.push(f);
			}
		}
	}

	final header = "package gdshader;\n\nimport gdshader.types.*;\n\n";
	File.saveContent(Path.join([gdshaderFolder, "Constructors.hx"]), '$header${constructors.join("\n")}\n');
	File.saveContent(Path.join([gdshaderFolder, "Functions.hx"]), '$header${functions.join("\n")}\n');
}
