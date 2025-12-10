package gdshader.modes;

import gdshader.types.*;

@:shaderType(sky)
extern class Sky {
	public function sky(): Void;

	final AT_CUBEMAP_PASS: Bool;
	final AT_HALF_RES_PASS: Bool;
	final AT_QUARTER_RES_PASS: Bool;
	final E: Float;
	final LIGHT0_COLOR: Vec3;
	final LIGHT0_DIRECTION: Vec3;
	final LIGHT0_ENABLED: Bool;
	final LIGHT0_ENERGY: Float;
	final LIGHT0_SIZE: Float;
	final LIGHT1_COLOR: Vec3;
	final LIGHT1_DIRECTION: Vec3;
	final LIGHT1_ENABLED: Bool;
	final LIGHT1_ENERGY: Float;
	final LIGHT1_SIZE: Float;
	final LIGHT2_COLOR: Vec3;
	final LIGHT2_DIRECTION: Vec3;
	final LIGHT2_ENABLED: Bool;
	final LIGHT2_ENERGY: Float;
	final LIGHT2_SIZE: Float;
	final LIGHT3_COLOR: Vec3;
	final LIGHT3_DIRECTION: Vec3;
	final LIGHT3_ENABLED: Bool;
	final LIGHT3_ENERGY: Float;
	final LIGHT3_SIZE: Float;
	final PI: Float;
	final POSITION: Vec3;
	final RADIANCE: SamplerCube;
	final TAU: Float;
	final TIME: Float;
	@:allowedStages(sky) final EYEDIR: Vec3;
	@:allowedStages(sky) final FRAGCOORD: Vec4;
	@:allowedStages(sky) final HALF_RES_COLOR: Vec4;
	@:allowedStages(sky) final QUARTER_RES_COLOR: Vec4;
	@:allowedStages(sky) final SCREEN_UV: Vec2;
	@:allowedStages(sky) final SKY_COORDS: Vec2;
	@:allowedStages(sky) var ALPHA: Float;
	@:allowedStages(sky) var COLOR: Vec3;
	@:allowedStages(sky) var FOG: Vec4;
}
