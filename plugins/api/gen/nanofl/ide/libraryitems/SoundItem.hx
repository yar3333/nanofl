package nanofl.ide.libraryitems;

extern class SoundItem extends nanofl.engine.libraryitems.SoundItem implements nanofl.ide.libraryitems.IIdeLibraryItem {
	function new(namePath:String, ext:String):Void;
	override function clone():nanofl.ide.libraryitems.SoundItem;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.SoundItem;
}