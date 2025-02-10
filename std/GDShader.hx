package;

/**
	This function should be called as a placeholder to be replaced with the
	value of the `@:constif` metadata that is attached to it.

	```haxe
	@:shader("MyShader", my_const_val = 12)
	class MyShader extends CanvasItem {
		override function fragment() {
			// This:
			final a: Int = constexpr(my_const_val);

			// Gets converted to this:
			final a: Int = 12;
		}
	}
**/
macro function constexpr<T>(expr: haxe.macro.Expr): haxe.macro.Expr {
	return macro @:constif($expr) __constexpr__();
}

#if !macro

/**
	Used internally by `constexpr(expr: Expr)`, should not be used directly.
	Tells Reflaxe/GDShader the value from the `@:constif` should be used.

	```haxe
	// This:
	final a: Int = @:constif(my_const_val) __constexpr__();

	// Gets converted to this:
	final a: Int = 12;
	```
**/
extern function __constexpr__<T>(): T;

/**
	Used to tell the Haxe compiler to shut up when it wants a variable to
	be initialized, but the variable should start uninitialized.
	
	```haxe
	// This:
	@:uniform final texture: Sampler2D = noinit();

	// Gets compiled as:
	uniform sampler2D texture;
	```

	```haxe
	// Also helpful for value-types that don't need to be initialized:
	var pos: Vec2 = noinit();

	// Gets compiled as:
	vec2 pos;
	```
**/
extern overload function noinit<T>(): T;

@:nativeFunctionCode("discard")
extern function discard(): Void;

extern var PI: Float;

@:native("int") extern overload function int(v: Float): Int;
@:native("float") extern overload function float(v: Int): Float;

@:native("vec2") extern overload function vec2(v: Float): Vec2;
@:native("vec2") extern overload function vec2(x: Float, y: Float): Vec2;

@:native("vec3") extern overload function vec3(v: Float): Vec3;
@:native("vec3") extern overload function vec3(x: Float, y: Float, z: Float): Vec3;

@:native("vec4") extern overload function vec4(v: Float): Vec4;
@:native("vec4") extern overload function vec4(rg: Vec2, b: Float, a: Float): Vec4;
@:native("vec4") extern overload function vec4(rg: Vec2, ba: Vec2): Vec4;
@:native("vec4") extern overload function vec4(rgb: Vec3, a: Float): Vec4;
@:native("vec4") extern overload function vec4(r: Float, gba: Vec3): Vec4;
@:native("vec4") extern overload function vec4(x: Float, y: Float, z: Float, w: Float): Vec4;

@:native("mat2") extern overload function mat2(a: Vec2, b: Vec2): Mat2;
@:native("mat3") extern overload function mat3(a: Vec3, b: Vec3, c: Vec3): Mat3;

extern function texture(sampler: Sampler2D, uv: Vec2): Vec4;
extern function textureLod(sampler: Sampler2D, uv: Vec2, lod: Float): Vec4;

extern function mix<T>(first: T, second: T, weight: Float): T;

extern function abs<T>(v: T): T;
extern function min<T>(v1: T, v2: T): T;
extern function max<T>(v1: T, v2: T): T;

extern function floor<T>(v: T): T;
extern function ceil<T>(v: T): T;
extern function round<T>(v: T): T;
overload extern function clamp<T>(v: T, min: T, max: T): T;
overload extern function clamp<T>(v: T, min: Float, max: Float): T;
extern function length(v: Vec2): Float;
extern function pow(v: Float, exponent: Float): Float;
extern function fract<T>(v: T): T;
extern function sqrt(v: Float): Float;
extern function sign(v: Float): Float;
extern function dot<T>(first: T, second: T): Float;

extern function mod<T, U>(x: T, y: U): T;

extern function sin<T>(v: T): T;
extern function cos(v: Float): Float;
extern function tan(v: Float): Float;
extern function asin(v: Float): Float;
extern function acos(v: Float): Float;
overload extern function atan(v: Float): Float;
overload extern function atan(y: Float, x: Float): Float;
extern function sinh(v: Float): Float;
extern function cosh(v: Float): Float;
extern function tanh(v: Float): Float;
extern function asinh(v: Float): Float;
extern function acosh(v: Float): Float;
extern function atanh(v: Float): Float;

extern function step(a: Float, b: Float): Float;
overload extern function smoothstep<T>(a: T, b: T, c: T): T;
overload extern function smoothstep<T>(a: Float, b: Float, c: T): T;

extern function dFdx(v: Float): Float;
extern function dFdy(v: Float): Float;

#end
