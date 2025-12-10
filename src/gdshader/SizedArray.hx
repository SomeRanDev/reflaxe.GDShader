package;

extern class ISizedArray<T> {
}

extern abstract SizedArray<T, @:const Size>(ISizedArray<T>) {
	@:arrayAccess public function get(key: Int): T;
	@:arrayAccess public function arrayWrite(k: Int, v: T): Void;
}
