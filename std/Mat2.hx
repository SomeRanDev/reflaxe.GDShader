package;

@:copyValue
@:avoidTemporaries
@:gdshaderType("mat2")
extern class IMat2 {
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("mat2")
extern abstract Mat2(IMat2) {
	@:op(A * B) public static inline function mulV2(me: Mat2, other: Vec2): Vec2
		return untyped __gdshader__("({0} * {1})", me, other);
}
