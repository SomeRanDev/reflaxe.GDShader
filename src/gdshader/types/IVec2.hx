package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("ivec2")
extern class IVec2Inner {
	var x: Int;
	var y: Int;
	var xx: IVec2;
	var xy: IVec2;
	var yx: IVec2;
	var yy: IVec2;
	var xxx: IVec3;
	var xxy: IVec3;
	var xyx: IVec3;
	var xyy: IVec3;
	var yxx: IVec3;
	var yxy: IVec3;
	var yyx: IVec3;
	var yyy: IVec3;
	var xxxx: IVec4;
	var xxxy: IVec4;
	var xxyx: IVec4;
	var xxyy: IVec4;
	var xyxx: IVec4;
	var xyxy: IVec4;
	var xyyx: IVec4;
	var xyyy: IVec4;
	var yxxx: IVec4;
	var yxxy: IVec4;
	var yxyx: IVec4;
	var yxyy: IVec4;
	var yyxx: IVec4;
	var yyxy: IVec4;
	var yyyx: IVec4;
	var yyyy: IVec4;
	var r: Int;
	var g: Int;
	var rr: IVec2;
	var rg: IVec2;
	var gr: IVec2;
	var gg: IVec2;
	var rrr: IVec3;
	var rrg: IVec3;
	var rgr: IVec3;
	var rgg: IVec3;
	var grr: IVec3;
	var grg: IVec3;
	var ggr: IVec3;
	var ggg: IVec3;
	var rrrr: IVec4;
	var rrrg: IVec4;
	var rrgr: IVec4;
	var rrgg: IVec4;
	var rgrr: IVec4;
	var rgrg: IVec4;
	var rggr: IVec4;
	var rggg: IVec4;
	var grrr: IVec4;
	var grrg: IVec4;
	var grgr: IVec4;
	var grgg: IVec4;
	var ggrr: IVec4;
	var ggrg: IVec4;
	var gggr: IVec4;
	var gggg: IVec4;
	var s: Int;
	var t: Int;
	var ss: IVec2;
	var st: IVec2;
	var ts: IVec2;
	var tt: IVec2;
	var sss: IVec3;
	var sst: IVec3;
	var sts: IVec3;
	var stt: IVec3;
	var tss: IVec3;
	var tst: IVec3;
	var tts: IVec3;
	var ttt: IVec3;
	var ssss: IVec4;
	var ssst: IVec4;
	var ssts: IVec4;
	var sstt: IVec4;
	var stss: IVec4;
	var stst: IVec4;
	var stts: IVec4;
	var sttt: IVec4;
	var tsss: IVec4;
	var tsst: IVec4;
	var tsts: IVec4;
	var tstt: IVec4;
	var ttss: IVec4;
	var ttst: IVec4;
	var ttts: IVec4;
	var tttt: IVec4;
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("ivec2")
extern abstract IVec2(IVec2Inner) {
	@:overload(function(x: Int, y: Int): Void {})
	@:overload(function(bvec2: BVec2): Void {})
	@:overload(function(ivec2: IVec2): Void {})
	@:overload(function(uvec2: UVec2): Void {})
	@:overload(function(vec2: Vec2): Void {})
	@:native("ivec2")
	public function new(int: Int);

	@:op(A == B) public static inline function equalsIVec2(me: IVec2, other: IVec2): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsIVec2(me: IVec2, other: IVec2): Bool return untyped __gdshader__("({0} != {1})", me, other);
	@:op(-A) public static inline function negate(me: IVec2): IVec2 return untyped __gdshader__("(-{0})", me);
	@:op(A + B) public static inline function addInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A + B) public static inline function addIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A - B) public static inline function subtractInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A - B) public static inline function subtractIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A * B) public static inline function multiplyInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function multiplyIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A / B) public static inline function divideInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A / B) public static inline function divideIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A % B) public static inline function modulusInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} % {1})", me, other);
	@:op(A % B) public static inline function modulusIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} % {1})", me, other);
	@:op(A << B) public static inline function shiftLeftInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} << {1})", me, other);
	@:op(A << B) public static inline function shiftLeftIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} << {1})", me, other);
	@:op(A >> B) public static inline function shiftRightInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} >> {1})", me, other);
	@:op(A >> B) public static inline function shiftRightIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} >> {1})", me, other);
	@:op(A += B) public static inline function addAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A += B) public static inline function addAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} += {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A -= B) public static inline function subtractAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} -= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A *= B) public static inline function multiplyAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} *= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A /= B) public static inline function divideAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} /= {1})", me, other);
	@:op(A %= B) public static inline function modulusAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} %= {1})", me, other);
	@:op(A %= B) public static inline function modulusAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} %= {1})", me, other);
	@:op(A <<= B) public static inline function shiftLeftAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} <<= {1})", me, other);
	@:op(A <<= B) public static inline function shiftLeftAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} <<= {1})", me, other);
	@:op(A >>= B) public static inline function shiftRightAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} >>= {1})", me, other);
	@:op(A >>= B) public static inline function shiftRightAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} >>= {1})", me, other);
	@:op(A &= B) public static inline function bitAndAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} &= {1})", me, other);
	@:op(A &= B) public static inline function bitAndAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} &= {1})", me, other);
	@:op(A |= B) public static inline function bitOrAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} |= {1})", me, other);
	@:op(A |= B) public static inline function bitOrAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} |= {1})", me, other);
	@:op(A ^= B) public static inline function bitXOrAssignInt(me: IVec2, other: Int): IVec2 return untyped __gdshader__("({0} ^= {1})", me, other);
	@:op(A ^= B) public static inline function bitXOrAssignIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} ^= {1})", me, other);
	@:op(A & B) public static inline function bitAndIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} & {1})", me, other);
	@:op(A | B) public static inline function bitOrIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} | {1})", me, other);
	@:op(A ^ B) public static inline function bitXOrIVec2(me: IVec2, other: IVec2): IVec2 return untyped __gdshader__("({0} ^ {1})", me, other);
	@:op(~A) public static inline function bitInvert(me: IVec2): IVec2 return untyped __gdshader__("(~{0})", me);
	@:op(++A) public static inline function increment(me: IVec2): IVec2 return untyped __gdshader__("(++{0})", me);
	@:op(--A) public static inline function decrement(me: IVec2): IVec2 return untyped __gdshader__("(--{0})", me);
	@:op(A++) public static inline function postIncrement(me: IVec2): IVec2 return untyped __gdshader__("({0}++)", me);
	@:op(A--) public static inline function postDecrement(me: IVec2): IVec2 return untyped __gdshader__("({0}--)", me);
	@:op(A + B) public static inline function addIntFlipped(other: Int, me: IVec2): IVec2 return untyped __gdshader__("({0} + {1})", other, me);
	@:op(A - B) public static inline function subtractIntFlipped(other: Int, me: IVec2): IVec2 return untyped __gdshader__("({0} - {1})", other, me);
	@:op(A * B) public static inline function multiplyIntFlipped(other: Int, me: IVec2): IVec2 return untyped __gdshader__("({0} * {1})", other, me);
	@:op(A / B) public static inline function divideIntFlipped(other: Int, me: IVec2): IVec2 return untyped __gdshader__("({0} / {1})", other, me);
}
