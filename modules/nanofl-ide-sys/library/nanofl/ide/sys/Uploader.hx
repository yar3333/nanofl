package nanofl.ide.sys;

@:rtti @:jsRequire("@nanofl/ide-sys", "Uploader") extern class Uploader {
	function new(fileSystem:nanofl.ide.sys.FileSystem):Void;
	function saveUploadedFiles(files:Array<js.html.File>, destDir:String):js.lib.Promise<{ }>;
}