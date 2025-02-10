package gdscompiler.config;

enum abstract Meta(String) from String to String {
	/**
		@:shader(path: String, ?RenderModes(mode1, mode2, ...), ...(key = value))

		Sets this class to be output as a `.gdshader` at `path`.
		Can be used multiple times on the same class to generate multiple `.gdshader` files.
	**/
	var Shader = ":shader";

	/**
		@:defaultRenderModes

		The render_modes used by a shader if none are defined in the second argument
		as `RenderModes(...)`.
	**/
	var DefaultRenderModes = ":defaultRenderModes";
}
