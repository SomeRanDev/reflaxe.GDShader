package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("usampler2DArray")
extern class USampler2DArrayInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("usampler2DArray")
extern abstract USampler2DArray(USampler2DArrayInner) {
	@:op(A == B) public static inline function equalsUSampler2DArray(me: USampler2DArray, other: USampler2DArray): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsUSampler2DArray(me: USampler2DArray, other: USampler2DArray): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
