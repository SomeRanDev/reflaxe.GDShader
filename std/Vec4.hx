package;

@:copyValue
@:avoidTemporaries
@:gdshaderType("vec4")
extern class IVec4 {
	public var x: Float;
	public var y: Float;
	public var z: Float;
	public var w: Float;

	public var r: Float;
	public var g: Float;
	public var b: Float;
	public var a: Float;

	public var rgb: Vec3;
}

@:forward
@:copyValue
@:avoidTemporaries
@:gdshaderType("vec4")
extern abstract Vec4(IVec4) {
	@:overload(function(): Void {})
	@:overload(function(v: Float): Void {})
	@:native("vec4")
	public function new(x: Float, y: Float, z: Float, w: Float);

	public extern inline function lerp(other: Vec4, weight: Float) {
		return GDShader.mix(abstract, other, weight);
	}
}
