package gdscompiler;

#if (macro || gdshader_runtime)

import haxe.macro.Compiler;
import haxe.macro.Expr;
import haxe.macro.Type;

import haxe.display.Display.MetadataTarget;

import reflaxe.ReflectCompiler;
import reflaxe.input.ExpressionModifier;
import reflaxe.preprocessors.ExpressionPreprocessor;
//import reflaxe.preprocessors.implementations.TemporaryVarRemover.TemporaryVarRemoverMode;

using reflaxe.helpers.ExprHelper;

class GDShaderCompilerInit {
	public static function Start() {
		if(isRunScript()) {
			return;
		}

		Compiler.addGlobalMetadata("StdTypes.Int", "@:build(gdshader.Init.initInt())");

		// Add our compiler to Reflaxe
		ReflectCompiler.AddCompiler(new GDShaderCompiler(), {
			expressionPreprocessors: [
				RemoveTemporaryVariables(AllOneUseVariables),
				RemoveTemporaryVariables(OnlyAvoidTemporaryFieldAccess),
				SanitizeEverythingIsExpression({}),
				PreventRepeatVariables({}),
				RemoveSingleExpressionBlocks,
				RemoveConstantBoolIfs,
				RemoveUnnecessaryBlocks,
				RemoveReassignedVariableDeclarations,
				RemoveLocalVariableAliases,
				MarkUnusedVariables,
			],
			fileOutputExtension: ".gdshader",
			outputDirDefineName: "gdshader-output",
			fileOutputType: FilePerClass,
			reservedVarNames: reservedNames(),
			targetCodeInjectionName: "__gdshader__",
			metadataTemplates: [
			]
		});
	}

	/**
		We don't want this running during our "Run.hx" script, so this checks if that is occuring.
	**/
	static function isRunScript() {
		return ["reflaxe.gdshader", "gdshader"].contains((Sys.getEnv("HAXELIB_RUN_NAME") ?? "").toLowerCase());
	}

	/**
		List of reserved words found here:
		https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/shading_language.html
	**/
	static var _reservedNames = [
		"void", "bool", "bvec2", "bvec3", "bvec4", "int", "ivec2", "ivec3", "ivec4", "uint", "uvec2", "uvec3", "uvec4",
		"float", "vec2", "vec3", "vec4", "mat2", "mat3", "mat4", "sampler2D", "isampler2D", "usampler2D", "sampler2DArray",
		"isampler2DArray", "usampler2DArray", "sampler3D", "isampler3D", "usampler3D", "samplerCube", "samplerCubeArray"
	];
	static function reservedNames() {
		return _reservedNames;
	}
}

#end
