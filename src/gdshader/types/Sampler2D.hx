package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("sampler2D")
extern class Sampler2DInner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("sampler2D")
extern abstract Sampler2D(Sampler2DInner) {
	@:op(A == B) public static inline function equalsSampler2D(me: Sampler2D, other: Sampler2D): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsSampler2D(me: Sampler2D, other: Sampler2D): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
