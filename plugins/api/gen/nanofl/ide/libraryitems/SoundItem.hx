package nanofl.ide.libraryitems;

extern class SoundItem extends nanofl.engine.libraryitems.SoundItem implements nanofl.ide.libraryitems.IIdeLibraryItem {
	function new(namePath:String, ext:String):Void;
	override function clone():nanofl.ide.libraryitems.SoundItem;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, mediaUtils:nanofl.ide.sys.MediaUtils, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getLibraryFilePaths():Array<String>;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.SoundItem;
}