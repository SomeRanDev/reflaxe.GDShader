package;

@:gdshaderType("vec3")
extern class Vec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;

	@:overload(function(): Void {})
	@:overload(function(v: Float): Void {})
	public function new(x: Float, y: Float, z: Float);
}
