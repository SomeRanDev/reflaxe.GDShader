package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("samplerCube")
extern class SamplerCubeInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("samplerCube")
extern abstract SamplerCube(SamplerCubeInner) {
	@:op(A == B) public static inline function equalsSamplerCube(me: SamplerCube, other: SamplerCube): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsSamplerCube(me: SamplerCube, other: SamplerCube): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
