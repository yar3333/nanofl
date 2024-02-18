package nanofl.ide;

extern class SafeCode {
	static function run(getErrorMessage:haxe.extern.EitherType<String, () -> String>, f:() -> Void, ?onError:({ public var stack(default, default) : String; public var message(default, default) : String; }) -> Void, ?p:haxe.PosInfos):Bool;
}