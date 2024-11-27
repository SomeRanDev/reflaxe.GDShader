package gdshader;

@:shaderType(canvas_item)
extern class CanvasItem extends Shader {
	var UV: Vec2;
	var SCREEN_UV: Vec2;
	var COLOR: Vec4;
	var TEXTURE: Sampler2D;
}
