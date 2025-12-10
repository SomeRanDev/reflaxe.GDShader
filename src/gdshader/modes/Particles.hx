package gdshader.modes;

import gdshader.types.*;

@:shaderType(particles)
extern class Particles {
	public function start(): Void;
	public function process(): Void;

	final E: Float;
	final PI: Float;
	final TAU: Float;
	final TIME: Float;
	@:allowedStages(start) final RESTART_COLOR: Bool;
	@:allowedStages(start) final RESTART_CUSTOM: Bool;
	@:allowedStages(start) final RESTART_POSITION: Bool;
	@:allowedStages(start) final RESTART_ROT_SCALE: Bool;
	@:allowedStages(start) final RESTART_VELOCITY: Bool;
	@:allowedStages(process) final ATTRACTOR_FORCE: Vec3;
	@:allowedStages(process) final COLLIDED: Bool;
	@:allowedStages(process) final COLLISION_DEPTH: Float;
	@:allowedStages(process) final COLLISION_NORMAL: Vec3;
	@:allowedStages(process) final RESTART: Bool;
	@:allowedStages(start, process) final AMOUNT_RATIO: Float;
	@:allowedStages(start, process) final DELTA: Float;
	@:allowedStages(start, process) final EMISSION_TRANSFORM: Mat4;
	@:allowedStages(start, process) final EMITTER_VELOCITY: Vec3;
	@:allowedStages(start, process) final FLAG_EMIT_COLOR: UInt;
	@:allowedStages(start, process) final FLAG_EMIT_CUSTOM: UInt;
	@:allowedStages(start, process) final FLAG_EMIT_POSITION: UInt;
	@:allowedStages(start, process) final FLAG_EMIT_ROT_SCALE: UInt;
	@:allowedStages(start, process) final FLAG_EMIT_VELOCITY: UInt;
	@:allowedStages(start, process) final INDEX: UInt;
	@:allowedStages(start, process) final INTERPOLATE_TO_END: Float;
	@:allowedStages(start, process) final LIFETIME: Float;
	@:allowedStages(start, process) final NUMBER: UInt;
	@:allowedStages(start, process) final RANDOM_SEED: UInt;
	@:allowedStages(start, process) var ACTIVE: Bool;
	@:allowedStages(start, process) var COLOR: Vec4;
	@:allowedStages(start, process) var CUSTOM: Vec4;
	@:allowedStages(start, process) var MASS: Float;
	@:allowedStages(start, process) var TRANSFORM: Mat4;
	@:allowedStages(start, process) var USERDATA1: Vec4;
	@:allowedStages(start, process) var USERDATA2: Vec4;
	@:allowedStages(start, process) var USERDATA3: Vec4;
	@:allowedStages(start, process) var USERDATA4: Vec4;
	@:allowedStages(start, process) var USERDATA5: Vec4;
	@:allowedStages(start, process) var USERDATA6: Vec4;
	@:allowedStages(start, process) var VELOCITY: Vec3;
}
