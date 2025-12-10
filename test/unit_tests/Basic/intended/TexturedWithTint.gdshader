shader_type canvas_item;

uniform sampler2D image;
uniform vec3 tint: source_color = vec3(1, 1, 1);

void fragment() {
	COLOR = texture(image, UV);
	(COLOR.xyz *= tint);
}