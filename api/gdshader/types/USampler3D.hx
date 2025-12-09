package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("usampler3D")
extern class USampler3DInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("usampler3D")
extern abstract USampler3D(USampler3DInner) {
	@:op(A == B) public static inline function equalsUSampler3D(me: USampler3D, other: USampler3D): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsUSampler3D(me: USampler3D, other: USampler3D): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
