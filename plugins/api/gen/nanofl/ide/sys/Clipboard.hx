package nanofl.ide.sys;

interface Clipboard {
	function hasText():Bool;
	function hasImage():Bool;
	function readText():String;
	function readImageAsPngBytes():haxe.io.Bytes;
	function writeText(data:String):Void;
}