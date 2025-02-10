package;

@:copyValue
@:avoidTemporaries
@:gdshaderType("mat4")
extern class IMat4 {
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("mat4")
extern abstract Mat4(IMat4) {
	@:op(A * B) public static inline function mulV4(me: Mat4, other: Vec4): Vec4
		return untyped __gdshader__("({0} * {1})", me, other);
}
