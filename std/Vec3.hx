package;

@:avoid_temporaries
@:gdshaderType("vec3")
extern class IVec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;
}

@:forward
@:avoid_temporaries
@:gdshaderType("vec3")
extern abstract Vec3(IVec3) {
	@:overload(function(): Void {})
	@:overload(function(v: Float): Void {})
	@:native("vec3")
	public function new(x: Float, y: Float, z: Float);

	public extern inline function lerp(other: Vec3, weight: Float) {
		return GDShader.mix(abstract, other, weight);
	}

	@:op(A * B) @:commutative public static inline function mulF(me: Vec3, other: Float): Vec3
		return untyped __gdshader__("{0} * {1}", me, other);
	@:op(A * B) public static inline function mulV(me: Vec3, other: Vec3): Vec3
		return untyped __gdshader__("{0} * {1}", me, other);
}
