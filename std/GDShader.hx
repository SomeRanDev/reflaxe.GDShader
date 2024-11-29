package;

extern overload function noinit<T>(): T;

@:native("float") extern overload function float(v: Int): Float;

@:native("vec2") extern overload function vec2(v: Float): Vec2;
@:native("vec2") extern overload function vec2(x: Float, y: Float): Vec2;

@:native("vec3") extern overload function vec3(v: Float): Vec3;
@:native("vec3") extern overload function vec3(x: Float, y: Float, z: Float): Vec3;

@:native("vec4") extern overload function vec4(v: Float): Vec4;
@:native("vec4") extern overload function vec4(rgb: Vec3, a: Float): Vec4;
@:native("vec4") extern overload function vec4(x: Float, y: Float, z: Float, w: Float): Vec4;

extern function texture(sampler: Sampler2D, uv: Vec2): Vec4;
extern function textureLod(sampler: Sampler2D, uv: Vec2, lod: Float): Vec4;

extern function mix<T>(first: T, second: T, weight: Float): T;

extern function abs(v: Float): Float;
extern function min(v1: Float, v2: Float): Float;
extern function max(v1: Float, v2: Float): Float;
extern function clamp(v: Float, min: Float, max: Float): Float;
extern function length(v: Vec2): Float;
extern function atan(y: Float, x: Float): Float;
extern function pow(v: Float, exponent: Float): Float;
