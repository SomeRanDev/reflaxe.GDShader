package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("isampler2D")
extern class ISampler2DInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("isampler2D")
extern abstract ISampler2D(ISampler2DInner) {
	@:op(A == B) public static inline function equalsISampler2D(me: ISampler2D, other: ISampler2D): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsISampler2D(me: ISampler2D, other: ISampler2D): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
