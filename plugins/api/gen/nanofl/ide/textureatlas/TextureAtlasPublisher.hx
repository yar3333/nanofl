package nanofl.ide.textureatlas;

extern class TextureAtlasPublisher {
	static function publish(fileSystem:nanofl.ide.sys.FileSystem, library:nanofl.ide.library.IdeLibrary, textureAtlasesParams:Map<String, nanofl.ide.textureatlas.TextureAtlasParams>, destDir:String, supportLocalFileOpen:Bool):Void;
	static function deleteFiles(fileSystem:nanofl.ide.sys.FileSystem, destDir:String):Void;
}