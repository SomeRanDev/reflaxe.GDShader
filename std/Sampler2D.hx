package;

@:gdshaderType("sampler2D")
extern class Sampler2D {
	public extern inline function sample(uv: Vec2): Vec4 {
		return GDShader.texture(this, uv);
	}

	public extern inline function sampleLod(uv: Vec2, lod: Float): Vec4 {
		return GDShader.textureLod(this, uv, lod);
	}
}
