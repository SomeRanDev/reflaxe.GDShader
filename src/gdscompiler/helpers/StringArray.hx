package gdscompiler.helpers;

class StringArray {
	public static function pushIfNotEmpty(self: Array<String>, value: String) {
		if(value.length > 0) {
			self.push(value);
		}
	}
}
