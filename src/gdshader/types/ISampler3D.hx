package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("isampler3D")
extern class ISampler3DInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("isampler3D")
extern abstract ISampler3D(ISampler3DInner) {
	@:op(A == B) public static inline function equalsISampler3D(me: ISampler3D, other: ISampler3D): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsISampler3D(me: ISampler3D, other: ISampler3D): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
