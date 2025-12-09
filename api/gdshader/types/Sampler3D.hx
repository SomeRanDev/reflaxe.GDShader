package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("sampler3D")
extern class Sampler3DInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("sampler3D")
extern abstract Sampler3D(Sampler3DInner) {
	@:op(A == B) public static inline function equalsSampler3D(me: Sampler3D, other: Sampler3D): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsSampler3D(me: Sampler3D, other: Sampler3D): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
