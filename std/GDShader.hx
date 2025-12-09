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

/**
	Generates `discard` statement. It is treated like a `return` in Haxe code.

	```haxe
	final a = if(UV.y < 0.5) {
		UV.y * 2.0;
	} else {
		discard();
	}
	```
**/
macro function discard(): haxe.macro.Expr {
	return macro @:discard return;
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

#end
