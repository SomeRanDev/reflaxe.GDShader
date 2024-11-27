package gdshader;

extern class Shader {
	var TIME: Float;

	public function vertex(): Void;
	public function fragment(): Void;
	public function light(): Void;
}
