package gdshader.modes;

import gdshader.types.*;

@:shaderType(canvas_item)
extern class CanvasItem {
	public function vertex(): Void;
	public function fragment(): Void;
	public function light(): Void;

	final E: Float;
	final PI: Float;
	final TAU: Float;
	final TIME: Float;
	@:allowedStages(vertex) final CANVAS_MATRIX: Mat4;
	@:allowedStages(vertex) final CUSTOM0: Vec4;
	@:allowedStages(vertex) final CUSTOM1: Vec4;
	@:allowedStages(vertex) final INSTANCE_CUSTOM: Vec4;
	@:allowedStages(vertex) final INSTANCE_ID: Int;
	@:allowedStages(vertex) final MODEL_MATRIX: Mat4;
	@:allowedStages(vertex) final SCREEN_MATRIX: Mat4;
	@:allowedStages(vertex) final VERTEX_ID: Int;
	@:allowedStages(vertex) var POINT_SIZE: Float;
	@:allowedStages(fragment) final NORMAL_TEXTURE: Sampler2D;
	@:allowedStages(fragment) final REGION_RECT: Vec4;
	@:allowedStages(fragment) final SCREEN_PIXEL_SIZE: Vec2;
	@:allowedStages(fragment) final SPECULAR_SHININESS_TEXTURE: Sampler2D;
	@:allowedStages(fragment) var NORMAL_MAP: Vec3;
	@:allowedStages(fragment) var NORMAL_MAP_DEPTH: Float;
	@:allowedStages(fragment) var SHADOW_VERTEX: Vec2;
	@:allowedStages(vertex, fragment) final AT_LIGHT_PASS: Bool;
	@:allowedStages(vertex, fragment) var VERTEX: Vec2;
	@:allowedStages(light) final LIGHT_COLOR: Vec4;
	@:allowedStages(light) final LIGHT_DIRECTION: Vec3;
	@:allowedStages(light) final LIGHT_ENERGY: Float;
	@:allowedStages(light) final LIGHT_IS_DIRECTIONAL: Bool;
	@:allowedStages(light) final LIGHT_POSITION: Vec3;
	@:allowedStages(light) var LIGHT: Vec4;
	@:allowedStages(light) var SHADOW_MODULATE: Vec4;
	@:allowedStages(fragment, light) final FRAGCOORD: Vec4;
	@:allowedStages(fragment, light) final POINT_COORD: Vec2;
	@:allowedStages(fragment, light) final SCREEN_UV: Vec2;
	@:allowedStages(fragment, light) final SPECULAR_SHININESS: Vec4;
	@:allowedStages(fragment, light) final TEXTURE: Sampler2D;
	@:allowedStages(fragment, light) var LIGHT_VERTEX: Vec3;
	@:allowedStages(fragment, light) var NORMAL: Vec3;
	@:allowedStages(vertex, fragment, light) final TEXTURE_PIXEL_SIZE: Vec2;
	@:allowedStages(vertex, fragment, light) var COLOR: Vec4;
	@:allowedStages(vertex, fragment, light) var UV: Vec2;
}
