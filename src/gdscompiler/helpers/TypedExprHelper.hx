package gdscompiler.helpers;

import haxe.macro.Type;

class TypedExprHelper {
	public static function isNoInitCall(e: TypedExpr): Bool {
		return switch(e) {
			case {
				expr: TCall({ expr: TField(_,
					FStatic(
						_.get() => { pack: ["_GDShader"], module: "GDShader" }, _.get() => { name: "noinit" }
					)
				) }, [])
			}: true;
			case _: false;
		}
	}
}
