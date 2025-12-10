package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("isampler2DArray")
extern class ISampler2DArrayInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("isampler2DArray")
extern abstract ISampler2DArray(ISampler2DArrayInner) {
	@:op(A == B) public static inline function equalsISampler2DArray(me: ISampler2DArray, other: ISampler2DArray): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsISampler2DArray(me: ISampler2DArray, other: ISampler2DArray): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
