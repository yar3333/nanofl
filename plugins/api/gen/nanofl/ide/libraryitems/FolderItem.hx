package nanofl.ide.libraryitems;

extern class FolderItem extends nanofl.engine.libraryitems.FolderItem implements nanofl.ide.libraryitems.IIdeLibraryItem {
	function new(namePath:String):Void;
	override function clone():nanofl.ide.libraryitems.FolderItem;
	override function save(fileSystem:nanofl.ide.sys.FileSystem):Void;
	function getLibraryFilePaths():Array<String>;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, mediaUtils:nanofl.ide.sys.MediaUtils, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.FolderItem;
}