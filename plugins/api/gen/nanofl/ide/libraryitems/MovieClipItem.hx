package nanofl.ide.libraryitems;

extern class MovieClipItem extends nanofl.engine.libraryitems.MovieClipItem implements nanofl.ide.ITimeline implements nanofl.ide.libraryitems.IIdeInstancableItem {
	function new(namePath:String):Void;
	override function clone():nanofl.ide.libraryitems.MovieClipItem;
	override function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):nanofl.MovieClip;
	override function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):Void;
	override function preload():js.lib.Promise<{ }>;
	function getUsedSymbolNamePaths():Array<String>;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getTimelineState():nanofl.ide.undo.states.TimelineState;
	function setTimelineState(state:nanofl.ide.undo.states.TimelineState):Void;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	static function createWithFrame(namePath:String, ?elements:Array<nanofl.engine.elements.Element>, ?layerName:String):nanofl.ide.libraryitems.MovieClipItem;
	static function parse(namePath:String, itemNode:htmlparser.HtmlNodeElement):nanofl.ide.libraryitems.MovieClipItem;
	static function parseJson(namePath:String, obj:Dynamic):nanofl.ide.libraryitems.MovieClipItem;
}