package nanofl.ide.libraryitems;

extern class FolderItem extends nanofl.engine.libraryitems.FolderItem implements nanofl.ide.libraryitems.IIdeLibraryItem {
	function new(namePath:String):Void;
	override function clone():nanofl.ide.libraryitems.FolderItem;
	override function save(fileSystem:nanofl.ide.sys.FileSystem):Void;
	function getLibraryFilePaths():Array<String>;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getFilePathToRunWithEditor():String;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.FolderItem;
}