package nanofl.ide;

extern class BytesTools {
	static function fromString(s:String):haxe.io.Bytes;
	static function toArray(data:haxe.io.Bytes):Array<Int>;
}