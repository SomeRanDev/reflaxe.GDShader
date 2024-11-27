shader_type canvas_item;

uniform vec3 color = vec3(1, 2, 3);
uniform float distortFreq = 3.0;

void fragment() {
	const float blackness = 0.45;

	if(COLOR.a > 0.0 && COLOR.r < blackness && COLOR.g < blackness && COLOR.b < blackness) {
		COLOR.rgb = vec3(0.0);
	} else {
		COLOR.rgb = color;
	}
}