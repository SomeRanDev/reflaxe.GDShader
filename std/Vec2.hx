package;

@:copyValue
@:avoidTemporaries
@:gdshaderType("vec2")
extern class IVec2 {
	public var x: Float;
	public var y: Float;

	public var xy: Vec2;
	public var yx: Vec2;
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("vec2")
extern abstract Vec2(IVec2) {
	@:overload(function(): Void {})
	@:overload(function(v: Float): Void {})
	@:native("vec2")
	public function new(x: Float, y: Float);

	public extern inline function lerp(other: Vec2, weight: Float) {
		return GDShader.mix(abstract, other, weight);
	}

	@:op(A + B) @:commutative public static inline function addF(me: Vec2, other: Float): Vec2
		return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A + B) public static inline function addV2(me: Vec2, other: Vec2): Vec2
		return untyped __gdshader__("({0} + {1})", me, other);
	@:op(A - B) public static inline function subF(me: Vec2, other: Float): Vec2
		return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A - B) public static inline function subFR(other: Float, me: Vec2): Vec2
		return untyped __gdshader__("({0} - {1})", other, me);
	@:op(A - B) public static inline function subV2(me: Vec2, other: Vec2): Vec2
		return untyped __gdshader__("({0} - {1})", me, other);
	@:op(A * B) @:commutative public static inline function mul(me: Vec2, other: Float): Vec2
		return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A * B) public static inline function mulV(me: Vec2, other: Vec2): Vec2
		return untyped __gdshader__("({0} * {1})", me, other);
	@:op(A / B) public static inline function divF(me: Vec2, other: Float): Vec2
		return untyped __gdshader__("({0} / {1})", me, other);
	@:op(A / B) public static inline function divFR(other: Float, me: Vec2): Vec2
		return untyped __gdshader__("({0} / {1})", other, me);
	@:op(A / B) public static inline function divV(me: Vec2, other: Vec2): Vec2
		return untyped __gdshader__("({0} / {1})", me, other);
}
