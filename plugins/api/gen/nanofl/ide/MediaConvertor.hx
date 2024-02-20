package nanofl.ide;

extern class MediaConvertor extends nanofl.ide.InjectContainer {
	function new():Void;
	function convertImage(srcFile:String, destFile:String, quality:Int):Bool;
	function convertAudio(srcFile:String, destFile:String, quality:Int):Bool;
}