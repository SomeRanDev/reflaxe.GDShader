package gdshader.modes;

import gdshader.types.*;

@:shaderType(fog)
extern class Fog {
	public function fog(): Void;

	final E: Float;
	final PI: Float;
	final TAU: Float;
	final TIME: Float;
	@:allowedStages(fog) final OBJECT_POSITION: Vec3;
	@:allowedStages(fog) final SDF: Float;
	@:allowedStages(fog) final SIZE: Vec3;
	@:allowedStages(fog) final UVW: Vec3;
	@:allowedStages(fog) final WORLD_POSITION: Vec3;
	@:allowedStages(fog) var ALBEDO: Vec3;
	@:allowedStages(fog) var DENSITY: Float;
	@:allowedStages(fog) var EMISSION: Vec3;
}
