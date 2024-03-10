package nanofl.ide.libraryitems;

extern class MovieClipItem extends nanofl.engine.libraryitems.MovieClipItem implements nanofl.ide.libraryitems.IIdeInstancableItem {
	function new(namePath:String):Void;
	override function clone():nanofl.ide.libraryitems.MovieClipItem;
	override function createDisplayObject():nanofl.MovieClip;
	function getUsedSymbolNamePaths():Array<String>;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getTimelineState():nanofl.ide.undo.states.TimelineState;
	function setTimelineState(state:nanofl.ide.undo.states.TimelineState):Void;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	function removeLayer(index:Int):Void;
	function removeLayerWithChildren(index:Int):Array<nanofl.engine.movieclip.Layer>;
	static function createWithFrame(namePath:String, ?elements:Array<nanofl.engine.elements.Element>, ?layerName:String):nanofl.ide.libraryitems.MovieClipItem;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.MovieClipItem;
	static function parseJson(namePath:String, obj:Dynamic):nanofl.ide.libraryitems.MovieClipItem;
}