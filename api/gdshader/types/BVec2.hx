package gdshader.types;

import gdshader.types.*;

@:copyValue
@:noCompletion
@:avoidTemporaries
@:gdshaderType("bvec2")
extern class BVec2Inner {
	var x: Bool;
	var y: Bool;
	var xx: BVec2;
	var xy: BVec2;
	var yx: BVec2;
	var yy: BVec2;
	var xxx: BVec3;
	var xxy: BVec3;
	var xyx: BVec3;
	var xyy: BVec3;
	var yxx: BVec3;
	var yxy: BVec3;
	var yyx: BVec3;
	var yyy: BVec3;
	var xxxx: BVec4;
	var xxxy: BVec4;
	var xxyx: BVec4;
	var xxyy: BVec4;
	var xyxx: BVec4;
	var xyxy: BVec4;
	var xyyx: BVec4;
	var xyyy: BVec4;
	var yxxx: BVec4;
	var yxxy: BVec4;
	var yxyx: BVec4;
	var yxyy: BVec4;
	var yyxx: BVec4;
	var yyxy: BVec4;
	var yyyx: BVec4;
	var yyyy: BVec4;
	var r: Bool;
	var g: Bool;
	var rr: BVec2;
	var rg: BVec2;
	var gr: BVec2;
	var gg: BVec2;
	var rrr: BVec3;
	var rrg: BVec3;
	var rgr: BVec3;
	var rgg: BVec3;
	var grr: BVec3;
	var grg: BVec3;
	var ggr: BVec3;
	var ggg: BVec3;
	var rrrr: BVec4;
	var rrrg: BVec4;
	var rrgr: BVec4;
	var rrgg: BVec4;
	var rgrr: BVec4;
	var rgrg: BVec4;
	var rggr: BVec4;
	var rggg: BVec4;
	var grrr: BVec4;
	var grrg: BVec4;
	var grgr: BVec4;
	var grgg: BVec4;
	var ggrr: BVec4;
	var ggrg: BVec4;
	var gggr: BVec4;
	var gggg: BVec4;
	var s: Bool;
	var t: Bool;
	var ss: BVec2;
	var st: BVec2;
	var ts: BVec2;
	var tt: BVec2;
	var sss: BVec3;
	var sst: BVec3;
	var sts: BVec3;
	var stt: BVec3;
	var tss: BVec3;
	var tst: BVec3;
	var tts: BVec3;
	var ttt: BVec3;
	var ssss: BVec4;
	var ssst: BVec4;
	var ssts: BVec4;
	var sstt: BVec4;
	var stss: BVec4;
	var stst: BVec4;
	var stts: BVec4;
	var sttt: BVec4;
	var tsss: BVec4;
	var tsst: BVec4;
	var tsts: BVec4;
	var tstt: BVec4;
	var ttss: BVec4;
	var ttst: BVec4;
	var ttts: BVec4;
	var tttt: BVec4;
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("bvec2")
extern abstract BVec2(BVec2Inner) {
	@:overload(function(x: Bool, y: Bool): Void {})
	@:overload(function(bvec2: BVec2): Void {})
	@:overload(function(ivec2: IVec2): Void {})
	@:overload(function(uvec2: UVec2): Void {})
	@:overload(function(vec2: Vec2): Void {})
	@:native("bvec2")
	public function new(bool: Bool);

	@:op(A == B) public static inline function equalsBVec2(me: BVec2, other: BVec2): Bool return untyped __gdshader__("({0} == {1})", me, other);
	@:op(A != B) public static inline function notEqualsBVec2(me: BVec2, other: BVec2): Bool return untyped __gdshader__("({0} != {1})", me, other);
}
