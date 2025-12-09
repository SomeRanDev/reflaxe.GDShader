shader_type canvas_item;

#include "res://Code/ShaderInc/Noise.gdshaderinc"
#include "res://Code/ShaderInc/HSL.gdshaderinc"

uniform vec3 color: source_color = vec3(1, 2, 3);
uniform float distortFreq = 3.0;

void fragment() {
	const float distortRatio = 0.09;

	COLOR = texture(TEXTURE, (UV + (_vec2(noise(((UV * distortFreq) + _vec2((TIME * 10.0)))) - 0.5) * distortRatio)));

	const float blackness = 0.45;

	if(COLOR.a > 0.0 && COLOR.r < blackness && COLOR.g < blackness && COLOR.b < blackness) {
		vec3 hsl;

		hsl.x = noise(((UV * 1.0) + (TIME * 3.0)));
		hsl.y = 1.0;
		hsl.z = 0.333;
		COLOR.rgb = hsl2rgb(hsl);
		/* @:constelse */ COLOR.rgb = _vec3(0.0);
	} else {
		COLOR.rgb = color;
	}
}