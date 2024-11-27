package;

extern class IVec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;
}

@:forward
@:gdshaderType("vec3")
extern abstract Vec3(IVec3) {
	@:overload(function(): Void {})
	@:overload(function(v: Float): Void {})
	public function new(x: Float, y: Float, z: Float);
}
