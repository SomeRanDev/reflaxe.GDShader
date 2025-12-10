package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("uvec2")
extern class UVec2Inner {
	var x: UInt;
	var y: UInt;
	var xx: UVec2;
	var xy: UVec2;
	var yx: UVec2;
	var yy: UVec2;
	var xxx: UVec3;
	var xxy: UVec3;
	var xyx: UVec3;
	var xyy: UVec3;
	var yxx: UVec3;
	var yxy: UVec3;
	var yyx: UVec3;
	var yyy: UVec3;
	var xxxx: UVec4;
	var xxxy: UVec4;
	var xxyx: UVec4;
	var xxyy: UVec4;
	var xyxx: UVec4;
	var xyxy: UVec4;
	var xyyx: UVec4;
	var xyyy: UVec4;
	var yxxx: UVec4;
	var yxxy: UVec4;
	var yxyx: UVec4;
	var yxyy: UVec4;
	var yyxx: UVec4;
	var yyxy: UVec4;
	var yyyx: UVec4;
	var yyyy: UVec4;
	var r: UInt;
	var g: UInt;
	var rr: UVec2;
	var rg: UVec2;
	var gr: UVec2;
	var gg: UVec2;
	var rrr: UVec3;
	var rrg: UVec3;
	var rgr: UVec3;
	var rgg: UVec3;
	var grr: UVec3;
	var grg: UVec3;
	var ggr: UVec3;
	var ggg: UVec3;
	var rrrr: UVec4;
	var rrrg: UVec4;
	var rrgr: UVec4;
	var rrgg: UVec4;
	var rgrr: UVec4;
	var rgrg: UVec4;
	var rggr: UVec4;
	var rggg: UVec4;
	var grrr: UVec4;
	var grrg: UVec4;
	var grgr: UVec4;
	var grgg: UVec4;
	var ggrr: UVec4;
	var ggrg: UVec4;
	var gggr: UVec4;
	var gggg: UVec4;
	var s: UInt;
	var t: UInt;
	var ss: UVec2;
	var st: UVec2;
	var ts: UVec2;
	var tt: UVec2;
	var sss: UVec3;
	var sst: UVec3;
	var sts: UVec3;
	var stt: UVec3;
	var tss: UVec3;
	var tst: UVec3;
	var tts: UVec3;
	var ttt: UVec3;
	var ssss: UVec4;
	var ssst: UVec4;
	var ssts: UVec4;
	var sstt: UVec4;
	var stss: UVec4;
	var stst: UVec4;
	var stts: UVec4;
	var sttt: UVec4;
	var tsss: UVec4;
	var tsst: UVec4;
	var tsts: UVec4;
	var tstt: UVec4;
	var ttss: UVec4;
	var ttst: UVec4;
	var ttts: UVec4;
	var tttt: UVec4;
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("uvec2")
extern abstract UVec2(UVec2Inner) {
	@:overload(function(x: UInt, y: UInt): Void {})
	@:overload(function(bvec2: BVec2): Void {})
	@:overload(function(ivec2: IVec2): Void {})
	@:overload(function(uvec2: UVec2): Void {})
	@:overload(function(vec2: Vec2): Void {})
	@:native("uvec2")
	public function new(uint: UInt);

	@:op(A == B) public static inline function equalsUVec2(me: UVec2, other: UVec2): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsUVec2(me: UVec2, other: UVec2): Bool return untyped __gdshader__("({0} != {1})", me, other);
	@:op(-A) public static inline function negate(me: UVec2): UVec2 return untyped __gdshader__("(-{0})", me);
	@:op(A + B) public static inline function addUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A + B) public static inline function addUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A - B) public static inline function subtractUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A - B) public static inline function subtractUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A * B) public static inline function multiplyUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A / B) public static inline function divideUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A / B) public static inline function divideUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A % B) public static inline function modulusUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} % {1})", me, other);
	@:op(A % B) public static inline function modulusUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} % {1})", me, other);
	@:op(A << B) public static inline function shiftLeftUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} << {1})", me, other);
	@:op(A << B) public static inline function shiftLeftUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} << {1})", me, other);
	@:op(A >> B) public static inline function shiftRightUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} >> {1})", me, other);
	@:op(A >> B) public static inline function shiftRightUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} >> {1})", me, other);
	@:op(A += B) public static inline function addAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A += B) public static inline function addAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A %= B) public static inline function modulusAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} %= {1})", me, other);
	@:op(A %= B) public static inline function modulusAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} %= {1})", me, other);
	@:op(A <<= B) public static inline function shiftLeftAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} <<= {1})", me, other);
	@:op(A <<= B) public static inline function shiftLeftAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} <<= {1})", me, other);
	@:op(A >>= B) public static inline function shiftRightAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} >>= {1})", me, other);
	@:op(A >>= B) public static inline function shiftRightAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} >>= {1})", me, other);
	@:op(A &= B) public static inline function bitAndAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} &= {1})", me, other);
	@:op(A &= B) public static inline function bitAndAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} &= {1})", me, other);
	@:op(A |= B) public static inline function bitOrAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} |= {1})", me, other);
	@:op(A |= B) public static inline function bitOrAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} |= {1})", me, other);
	@:op(A ^= B) public static inline function bitXOrAssignUInt(me: UVec2, other: UInt): UVec2 return untyped __gdshader__("({0} ^= {1})", me, other);
	@:op(A ^= B) public static inline function bitXOrAssignUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} ^= {1})", me, other);
	@:op(A & B) public static inline function bitAndUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} & {1})", me, other);
	@:op(A | B) public static inline function bitOrUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} | {1})", me, other);
	@:op(A ^ B) public static inline function bitXOrUVec2(me: UVec2, other: UVec2): UVec2 return untyped __gdshader__("({0} ^ {1})", me, other);
	@:op(~A) public static inline function bitInvert(me: UVec2): UVec2 return untyped __gdshader__("(~{0})", me);
	@:op(++A) public static inline function increment(me: UVec2): UVec2 return untyped __gdshader__("(++{0})", me);
	@:op(--A) public static inline function decrement(me: UVec2): UVec2 return untyped __gdshader__("(--{0})", me);
	@:op(A++) public static inline function postIncrement(me: UVec2): UVec2 return untyped __gdshader__("({0}++)", me);
	@:op(A--) public static inline function postDecrement(me: UVec2): UVec2 return untyped __gdshader__("({0}--)", me);
	@:op(A + B) public static inline function addUIntFlipped(other: UInt, me: UVec2): UVec2 return untyped __gdshader__("({0} + {1})", other, me);
	@:op(A - B) public static inline function subtractUIntFlipped(other: UInt, me: UVec2): UVec2 return untyped __gdshader__("({0} - {1})", other, me);
	@:op(A * B) public static inline function multiplyUIntFlipped(other: UInt, me: UVec2): UVec2 return untyped __gdshader__("({0} * {1})", other, me);
	@:op(A / B) public static inline function divideUIntFlipped(other: UInt, me: UVec2): UVec2 return untyped __gdshader__("({0} / {1})", other, me);
}
