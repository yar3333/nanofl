package nanofl.ide.libraryitems;

extern class BitmapItem extends nanofl.engine.libraryitems.BitmapItem implements nanofl.ide.libraryitems.IIdeInstancableItem {
	function new(namePath:String, ext:String):Void;
	override function clone():nanofl.ide.libraryitems.BitmapItem;
	override function preload():js.lib.Promise<{ }>;
	override function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	function getUrl():String;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getUsedSymbolNamePaths():Array<String>;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.BitmapItem;
}