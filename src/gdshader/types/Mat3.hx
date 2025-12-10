package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("mat3")
extern class Mat3Inner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("mat3")
extern abstract Mat3(Mat3Inner) {
	@:overload(function(float: Float): Void {})
	@:overload(function(mat2: Mat2): Void {})
	@:overload(function(mat4: Mat4): Void {})
	@:native("mat3")
	public function new(x: Vec3, y: Vec3, z: Vec3);

	@:op(A == B) public static inline function equalsMat3(me: Mat3, other: Mat3): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsMat3(me: Mat3, other: Mat3): Bool return untyped __gdshader__("({0} != {1})", me, other);
	@:op(A + B) public static inline function addFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A + B) public static inline function addMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A - B) public static inline function subtractFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A - B) public static inline function subtractMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A * B) public static inline function multiplyFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyVec3(me: Mat3, other: Vec3): Vec3 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A / B) public static inline function divideFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A / B) public static inline function divideMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A += B) public static inline function addAssignFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A += B) public static inline function addAssignMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignFloat(me: Mat3, other: Float): Mat3 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignMat3(me: Mat3, other: Mat3): Mat3 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A + B) public static inline function addFloatFlipped(other: Float, me: Mat3): Mat3 return untyped __gdshader__("({0} + {1})", other, me);
	@:op(A - B) public static inline function subtractFloatFlipped(other: Float, me: Mat3): Mat3 return untyped __gdshader__("({0} - {1})", other, me);
	@:op(A * B) public static inline function multiplyFloatFlipped(other: Float, me: Mat3): Mat3 return untyped __gdshader__("({0} * {1})", other, me);
	@:op(A / B) public static inline function divideFloatFlipped(other: Float, me: Mat3): Mat3 return untyped __gdshader__("({0} / {1})", other, me);
}
