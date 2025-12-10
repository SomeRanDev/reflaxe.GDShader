package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("mat4")
extern class Mat4Inner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("mat4")
extern abstract Mat4(Mat4Inner) {
	@:overload(function(float: Float): Void {})
	@:overload(function(mat2: Mat2): Void {})
	@:overload(function(mat3: Mat3): Void {})
	@:native("mat4")
	public function new(x: Vec4, y: Vec4, z: Vec4, w: Vec4);

	@:op(A == B) public static inline function equalsMat4(me: Mat4, other: Mat4): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsMat4(me: Mat4, other: Mat4): Bool return untyped __gdshader__("({0} != {1})", me, other);
	@:op(A + B) public static inline function addFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A + B) public static inline function addMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A - B) public static inline function subtractFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A - B) public static inline function subtractMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A * B) public static inline function multiplyFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyVec4(me: Mat4, other: Vec4): Vec4 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A / B) public static inline function divideFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A / B) public static inline function divideMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A += B) public static inline function addAssignFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A += B) public static inline function addAssignMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignFloat(me: Mat4, other: Float): Mat4 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignMat4(me: Mat4, other: Mat4): Mat4 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A + B) public static inline function addFloatFlipped(other: Float, me: Mat4): Mat4 return untyped __gdshader__("({0} + {1})", other, me);
	@:op(A - B) public static inline function subtractFloatFlipped(other: Float, me: Mat4): Mat4 return untyped __gdshader__("({0} - {1})", other, me);
	@:op(A * B) public static inline function multiplyFloatFlipped(other: Float, me: Mat4): Mat4 return untyped __gdshader__("({0} * {1})", other, me);
	@:op(A / B) public static inline function divideFloatFlipped(other: Float, me: Mat4): Mat4 return untyped __gdshader__("({0} / {1})", other, me);
}
