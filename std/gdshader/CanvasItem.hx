package gdshader;

@:shaderType(canvas_item)
extern class CanvasItem extends Shader {
	@:onlyAllowIn(vertex) var MODEL_MATRIX: Mat4;
	@:onlyAllowIn(vertex) var INSTANCE_CUSTOM: Vec4;
	@:onlyAllowIn(vertex) var INSTANCE_ID: Int;
	@:onlyAllowIn(vertex, fragment) var VERTEX: Vec2;
	@:onlyAllowIn(vertex, fragment, light) var UV: Vec2;
	@:onlyAllowIn(fragment, light) var SCREEN_UV: Vec2;
	@:onlyAllowIn(fragment, light) var FRAGCOORD: Vec4;
	@:onlyAllowIn(fragment) var COLOR: Vec4;
	@:onlyAllowIn(fragment) var TEXTURE: Sampler2D;
	@:onlyAllowIn(fragment) var SCREEN_PIXEL_SIZE: Vec2;
}
