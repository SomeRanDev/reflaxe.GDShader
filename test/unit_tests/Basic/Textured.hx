package;

import GDShader;
import gdshader.Constructors;
import gdshader.modes.CanvasItem;
import gdshader.types.*;

import gdshader.Functions;

/**
    Generates both `Textured.gdshader` and `TexturedWithTint.gdshader`.

    `TexturedWithTint.gdshader` has an additional `tint` parameter that `Textured.gdshader` does not.
**/
@:shader("Textured", hasTint = false)
@:shader("TexturedWithTint", hasTint = true)
class Textured extends CanvasItem {
    @:uniform
    var image: Sampler2D;

    @:constif(hasTint)
    @:uniform
    @:color
    var tint = new Vec3(1, 1, 1);

    public override function fragment() {
        COLOR = texture(image, UV);
        @:constif(hasTint) {
            COLOR.xyz *= tint;
        }
    }
}
