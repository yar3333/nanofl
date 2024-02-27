package nanofl.ide.libraryitems;

extern class MeshItem extends nanofl.engine.libraryitems.MeshItem implements nanofl.ide.libraryitems.IIdeInstancableItem {
	function new(namePath:String, ext:String, originalExt:String):Void;
	override function clone():nanofl.ide.libraryitems.MeshItem;
	override function preload():js.lib.Promise<{ }>;
	override function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getUsedSymbolNamePaths():Array<String>;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.MeshItem;
	static function load(namePath:String, originalExt:String, files:Map<String, nanofl.ide.filesystem.CachedFile>):nanofl.ide.libraryitems.MeshItem;
}