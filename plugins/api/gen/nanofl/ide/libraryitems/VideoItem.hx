package nanofl.ide.libraryitems;

extern class VideoItem extends nanofl.engine.libraryitems.VideoItem implements nanofl.ide.libraryitems.IIdeInstancableItem {
	function new(namePath:String, ext:String):Void;
	override function clone():nanofl.ide.libraryitems.VideoItem;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	function getUrl():String;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getUsedSymbolNamePaths():js.lib.Set<String>;
	override function createDisplayObject():nanofl.Video;
	static function parse(namePath:String, xml:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.VideoItem;
}