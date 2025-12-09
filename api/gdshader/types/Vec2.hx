package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("vec2")
extern class Vec2Inner {
	var x: Float;
	var y: Float;
	var xx: Vec2;
	var xy: Vec2;
	var yx: Vec2;
	var yy: Vec2;
	var xxx: Vec3;
	var xxy: Vec3;
	var xyx: Vec3;
	var xyy: Vec3;
	var yxx: Vec3;
	var yxy: Vec3;
	var yyx: Vec3;
	var yyy: Vec3;
	var xxxx: Vec4;
	var xxxy: Vec4;
	var xxyx: Vec4;
	var xxyy: Vec4;
	var xyxx: Vec4;
	var xyxy: Vec4;
	var xyyx: Vec4;
	var xyyy: Vec4;
	var yxxx: Vec4;
	var yxxy: Vec4;
	var yxyx: Vec4;
	var yxyy: Vec4;
	var yyxx: Vec4;
	var yyxy: Vec4;
	var yyyx: Vec4;
	var yyyy: Vec4;
	var r: Float;
	var g: Float;
	var rr: Vec2;
	var rg: Vec2;
	var gr: Vec2;
	var gg: Vec2;
	var rrr: Vec3;
	var rrg: Vec3;
	var rgr: Vec3;
	var rgg: Vec3;
	var grr: Vec3;
	var grg: Vec3;
	var ggr: Vec3;
	var ggg: Vec3;
	var rrrr: Vec4;
	var rrrg: Vec4;
	var rrgr: Vec4;
	var rrgg: Vec4;
	var rgrr: Vec4;
	var rgrg: Vec4;
	var rggr: Vec4;
	var rggg: Vec4;
	var grrr: Vec4;
	var grrg: Vec4;
	var grgr: Vec4;
	var grgg: Vec4;
	var ggrr: Vec4;
	var ggrg: Vec4;
	var gggr: Vec4;
	var gggg: Vec4;
	var s: Float;
	var t: Float;
	var ss: Vec2;
	var st: Vec2;
	var ts: Vec2;
	var tt: Vec2;
	var sss: Vec3;
	var sst: Vec3;
	var sts: Vec3;
	var stt: Vec3;
	var tss: Vec3;
	var tst: Vec3;
	var tts: Vec3;
	var ttt: Vec3;
	var ssss: Vec4;
	var ssst: Vec4;
	var ssts: Vec4;
	var sstt: Vec4;
	var stss: Vec4;
	var stst: Vec4;
	var stts: Vec4;
	var sttt: Vec4;
	var tsss: Vec4;
	var tsst: Vec4;
	var tsts: Vec4;
	var tstt: Vec4;
	var ttss: Vec4;
	var ttst: Vec4;
	var ttts: Vec4;
	var tttt: Vec4;
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("vec2")
extern abstract Vec2(Vec2Inner) {
	@:overload(function(x: Float, y: Float): Void {})
	@:overload(function(bvec2: BVec2): Void {})
	@:overload(function(ivec2: IVec2): Void {})
	@:overload(function(uvec2: UVec2): Void {})
	@:overload(function(vec2: Vec2): Void {})
	@:native("vec2")
	public function new(float: Float);

	@:op(A == B) public static inline function equalsVec2(me: Vec2, other: Vec2): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsVec2(me: Vec2, other: Vec2): Bool return untyped __gdshader__("({0} != {1})", me, other);
	@:op(-A) public static inline function negate(me: Vec2): Vec2 return untyped __gdshader__("(-{0})", me);
	@:op(A + B) public static inline function addFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A + B) public static inline function addVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A - B) public static inline function subtractFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A - B) public static inline function subtractVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A * B) public static inline function multiplyFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyMat2(me: Vec2, other: Mat2): Vec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A / B) public static inline function divideFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A / B) public static inline function divideVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A += B) public static inline function addAssignFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A += B) public static inline function addAssignVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignMat2(me: Vec2, other: Mat2): Vec2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignFloat(me: Vec2, other: Float): Vec2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignVec2(me: Vec2, other: Vec2): Vec2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(++A) public static inline function increment(me: Vec2): Vec2 return untyped __gdshader__("(++{0})", me);
	@:op(--A) public static inline function decrement(me: Vec2): Vec2 return untyped __gdshader__("(--{0})", me);
	@:op(A++) public static inline function postIncrement(me: Vec2): Vec2 return untyped __gdshader__("({0}++)", me);
	@:op(A--) public static inline function postDecrement(me: Vec2): Vec2 return untyped __gdshader__("({0}--)", me);
	@:op(A + B) public static inline function addFloatFlipped(other: Float, me: Vec2): Vec2 return untyped __gdshader__("({0} + {1})", other, me);
	@:op(A - B) public static inline function subtractFloatFlipped(other: Float, me: Vec2): Vec2 return untyped __gdshader__("({0} - {1})", other, me);
	@:op(A * B) public static inline function multiplyFloatFlipped(other: Float, me: Vec2): Vec2 return untyped __gdshader__("({0} * {1})", other, me);
	@:op(A / B) public static inline function divideFloatFlipped(other: Float, me: Vec2): Vec2 return untyped __gdshader__("({0} / {1})", other, me);
}
