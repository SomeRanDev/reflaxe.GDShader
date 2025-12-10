package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("samplerExternalOES")
extern class SamplerExternalOESInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("samplerExternalOES")
extern abstract SamplerExternalOES(SamplerExternalOESInner) {
	@:op(A == B) public static inline function equalsSamplerExternalOES(me: SamplerExternalOES, other: SamplerExternalOES): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsSamplerExternalOES(me: SamplerExternalOES, other: SamplerExternalOES): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
