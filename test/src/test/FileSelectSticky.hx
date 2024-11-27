package test;

import GDShader;
import gdshader.CanvasItem;

@:include("res://Code/ShaderInc/Noise.gdshaderinc")
extern function noise(pos: Vec2): Float;

@:include("res://Code/ShaderInc/HSL.gdshaderinc")
extern function hsl2rgb(hsl: Vec3): Vec3;

@:include("res://Code/ShaderInc/FloatMod.gdshaderinc")
extern function decimalPlace(v: Float): Float;

@:shader("2d/FileSelect/FileSelectStickyNote", type = StickyNote, hovered = false)
@:shader("2d/FileSelect/FileSelectNewGame", type = NewGame, hovered = false)
@:shader("2d/FileSelect/FileSelectStickyNote_Hovered", type = StickyNote, hovered = true)
@:shader("2d/FileSelect/FileSelectNewGame_Hovered", type = NewGame, hovered = true)
class FileSelectSticky extends CanvasItem {
	/**
		Set to `true` when hovered.
	**/
	// @:uniform
	// var isHovered: Bool = false;

	@:constif(type == StickyNote)
	@:uniform @:color
	var color = new Vec3(1, 2, 3);

	final distortFreq: Float = 3.0;

	public override function fragment() {
		@:constif(hovered) {
			final t = TIME * 10.0;
			final scaledUV = UV * distortFreq;
			final newUV = vec2(noise(scaledUV + vec2(t)) - 0.5);
			@:const final distortRatio = 0.09;//isHovered ? 0.09 : 0.0;
			final newUV = UV + (newUV * distortRatio);
			COLOR = TEXTURE.sample(newUV);
		}

		@:const final blackness = 0.45;
		final is_black = COLOR.a > 0.0 && COLOR.r < blackness && COLOR.g < blackness && COLOR.b < blackness;
		if(is_black) {
			@:constif(hovered) {
				final hsl: Vec3 = noinit();
				hsl.x = noise((UV * 1.0) + (TIME * 3.0));
				hsl.y = 1.0;
				hsl.z = 0.333;
				COLOR.rgb = hsl2rgb(hsl);
			}
			@:constif(!hovered) {
				COLOR.rgb = vec3(0.0);
			}
		} else @:constif(type == StickyNote) {
			COLOR.rgb = color;
		}
	}
}

/*

uniform bool is_hovered = false;

uniform vec3 color : source_color;

const float distort_freq = 3.0;

void fragment() {
	if(is_hovered) {
		float t = float(TIME * 10.0);
		float new_uv_x = noise((UV * distort_freq) + vec2(t)) - 0.5;
		float new_uv_y = noise((UV * distort_freq) + vec2(t)) - 0.5;

		float distort_ratio = is_hovered ? 0.09 : 0.0;
		vec2 new_uv = UV + (vec2(new_uv_x, new_uv_y) * distort_ratio);
		COLOR = texture(TEXTURE, new_uv);
	}

	const float blackness = 0.45;
	bool is_black = COLOR.a > 0.0 && COLOR.r < blackness && COLOR.g < blackness && COLOR.b < blackness;
	if(is_black) {
		if(is_hovered) {
			vec3 hsl;
			hsl.x = noise((UV * 1.0) + (TIME * 3.0));
			hsl.y = 1.0;
			hsl.z = 0.333;
			COLOR.rgb = hsl2rgb(hsl);
		} else {
			COLOR.rgb = vec3(0.0);
		}
	} else {
		COLOR.rgb = color;
	}
}

*/
