package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("usampler2D")
extern class USampler2DInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("usampler2D")
extern abstract USampler2D(USampler2DInner) {
	@:op(A == B) public static inline function equalsUSampler2D(me: USampler2D, other: USampler2D): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsUSampler2D(me: USampler2D, other: USampler2D): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
