package nanofl.ide.libraryitems;

extern class SpriteItem extends nanofl.engine.libraryitems.SpriteItem implements nanofl.ide.libraryitems.IIdeInstancableItem {
	function new(namePath:String, frames:Array<nanofl.engine.SpriteItemFrame>):Void;
	override function save(fileSystem:nanofl.ide.sys.FileSystem):Void;
	override function preload():js.lib.Promise<{ }>;
	override function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getUsedSymbolNamePaths():Array<String>;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.SpriteItem;
}