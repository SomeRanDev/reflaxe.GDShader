package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("samplerCubeArray")
extern class SamplerCubeArrayInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("samplerCubeArray")
extern abstract SamplerCubeArray(SamplerCubeArrayInner) {
	@:op(A == B) public static inline function equalsSamplerCubeArray(me: SamplerCubeArray, other: SamplerCubeArray): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsSamplerCubeArray(me: SamplerCubeArray, other: SamplerCubeArray): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
