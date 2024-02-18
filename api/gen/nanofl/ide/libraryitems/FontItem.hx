package nanofl.ide.libraryitems;

extern class FontItem extends nanofl.engine.libraryitems.FontItem implements nanofl.ide.libraryitems.IIdeLibraryItem {
	function new(namePath:String, ?variants:Array<nanofl.engine.FontVariant>):Void;
	override function clone():nanofl.ide.libraryitems.FontItem;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.FontItem;
}