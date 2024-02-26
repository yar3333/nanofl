package nanofl.engine;

extern class SerializationAsJsTools {
	static function save(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String, namePath:String, data:Dynamic):Void;
	static function load(library:nanofl.engine.Library, namePath:String, removeAfterLoad:Bool):js.lib.Promise<Dynamic>;
}