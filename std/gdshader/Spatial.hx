package gdshader;

@:shaderType(spatial)
extern class Spatial extends Shader {
	@:onlyAllowIn(vertex) var POSITION: Vec4;
	// @:onlyAllowIn(vertex) var INSTANCE_CUSTOM: Vec4;
	@:onlyAllowIn(vertex, fragment) var VERTEX: Vec3;
	@:onlyAllowIn(fragment) var SCREEN_UV: Vec2;
	@:onlyAllowIn(fragment) var UV: Vec2;
	@:onlyAllowIn(fragment) var ALBEDO: Vec3;
	@:onlyAllowIn(fragment) var ROUGHNESS: Float;
	@:onlyAllowIn(fragment) var EMISSION: Vec3;
	@:onlyAllowIn(fragment) var ALPHA: Float;
	@:onlyAllowIn(fragment) var ALPHA_SCISSOR_THRESHOLD: Float;
	// @:onlyAllowIn(vertex, fragment, light) var UV: Vec2;
	// @:onlyAllowIn(fragment, light) var SCREEN_UV: Vec2;
	@:onlyAllowIn(fragment, light) var FRAGCOORD: Vec4;
	// @:onlyAllowIn(fragment) var COLOR: Vec4;
	// @:onlyAllowIn(fragment) var TEXTURE: Sampler2D;
	// @:onlyAllowIn(fragment) var SCREEN_PIXEL_SIZE: Vec2;
	@:onlyAllowIn(vertex, fragment, light) var VIEWPORT_SIZE: Vec2;
	@:onlyAllowIn(vertex, fragment, light) var NORMAL: Vec3;

	@:onlyAllowIn(light) var LIGHT: Vec3;
	@:onlyAllowIn(light) var ATTENUATION: Float;
	@:onlyAllowIn(light) var DIFFUSE_LIGHT: Vec3;
}
