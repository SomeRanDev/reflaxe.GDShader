package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("mat2")
extern class Mat2Inner {}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("mat2")
extern abstract Mat2(Mat2Inner) {
	@:overload(function(float: Float): Void {})
	@:overload(function(mat3: Mat3): Void {})
	@:overload(function(mat4: Mat4): Void {})
	@:native("mat2")
	public function new(x: Vec2, y: Vec2);

	@:op(A == B) public static inline function equalsMat2(me: Mat2, other: Mat2): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsMat2(me: Mat2, other: Mat2): Bool return untyped __gdshader__("({0} != {1})", me, other);
	@:op(A + B) public static inline function addFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A + B) public static inline function addMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A - B) public static inline function subtractFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A - B) public static inline function subtractMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A * B) public static inline function multiplyFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyVec2(me: Mat2, other: Vec2): Vec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A / B) public static inline function divideFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A / B) public static inline function divideMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A += B) public static inline function addAssignFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A += B) public static inline function addAssignMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignFloat(me: Mat2, other: Float): Mat2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignMat2(me: Mat2, other: Mat2): Mat2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A + B) public static inline function addFloatFlipped(other: Float, me: Mat2): Mat2 return untyped __gdshader__("({0} + {1})", other, me);
	@:op(A - B) public static inline function subtractFloatFlipped(other: Float, me: Mat2): Mat2 return untyped __gdshader__("({0} - {1})", other, me);
	@:op(A * B) public static inline function multiplyFloatFlipped(other: Float, me: Mat2): Mat2 return untyped __gdshader__("({0} * {1})", other, me);
	@:op(A / B) public static inline function divideFloatFlipped(other: Float, me: Mat2): Mat2 return untyped __gdshader__("({0} / {1})", other, me);
}
