package nanofl.ide.libraryitems;

extern class VideoItem extends nanofl.engine.libraryitems.VideoItem implements nanofl.ide.libraryitems.IIdeInstancableItem {
	function new(namePath:String, ext:String):Void;
	override function clone():nanofl.ide.libraryitems.VideoItem;
	function getLibraryFilePaths():Array<String>;
	function getUrl():String;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, mediaUtils:nanofl.ide.sys.MediaUtils, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getUsedSymbolNamePaths():js.lib.Set<String>;
	override function createDisplayObject(params:Dynamic):nanofl.ide.displayobjects.IdeVideo;
	static function parse(namePath:String, xml:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.VideoItem;
}