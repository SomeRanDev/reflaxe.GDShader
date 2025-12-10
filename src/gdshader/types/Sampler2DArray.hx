package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("sampler2DArray")
extern class Sampler2DArrayInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("sampler2DArray")
extern abstract Sampler2DArray(Sampler2DArrayInner) {
	@:op(A == B) public static inline function equalsSampler2DArray(me: Sampler2DArray, other: Sampler2DArray): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsSampler2DArray(me: Sampler2DArray, other: Sampler2DArray): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
