package components.nanofl.movie.timeline;

extern class TimelineAdapterToEditor implements components.nanofl.movie.timeline.ITimelineAdapter {
	function new(editor:nanofl.ide.editor.Editor, undoQueue:nanofl.ide.undo.document.UndoQueue, library:nanofl.ide.library.IdeLibrary, preferences:nanofl.ide.preferences.Preferences, pathItem:nanofl.ide.navigator.PathItem, navigator:nanofl.ide.navigator.Navigator, properties:nanofl.ide.DocumentProperties):Void;
	var layers(get, never) : datatools.ArrayRO<TLLayer>;
	private function get_layers():datatools.ArrayRO<TLLayer>;
	var editable(get, never) : Bool;
	private function get_editable():Bool;
	var frameIndex(get, set) : Int;
	private function get_frameIndex():Int;
	private function set_frameIndex(n:Int):Int;
	var layerIndex(get, set) : Int;
	private function get_layerIndex():Int;
	private function set_layerIndex(n:Int):Int;
	var framerate(get, never) : Float;
	private function get_framerate():Float;
	var xmlLayersTag(default, null) : String;
	function beginTransaction():Void;
	function commitTransaction():Void;
	function getLayerContextMenu():Array<nanofl.ide.ui.menu.MenuItem>;
	function getFrameContextMenu():Array<nanofl.ide.ui.menu.MenuItem>;
	function getLibraryItems(namePaths:Array<String>):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function addNewKeyFrameToLayer(layer:TLLayer):Void;
	function newLayer(name:String, ?type:nanofl.engine.LayerType):TLLayer;
	function parseLayer(layerNode:htmlparser.HtmlNodeElement, version:String):TLLayer;
	function onLayerAdded():Void;
	function onLayerRemoved():Void;
	function onLayerVisibleChange():Void;
	function onLayerLockChange():Void;
	function onTweenCreated():Void;
	function onTweenRemoved():Void;
	function onConvertToKeyFrame():Void;
	function onFrameRemoved():Void;
	function onLayersSelectionChange(indexes:Array<Int>):Void;
	function getTotalFrames():Int;
	function addLayersBlock(layersToAdd:datatools.ArrayRO<TLLayer>, ?index:Int):Void;
	function removeLayer(index:Int):Void;
	function addLayer(layer:TLLayer):Void;
	function getNamePaths(keyFrame:TLKeyFrame):Array<String>;
	function getLayerNestLevel(layer:TLLayer):Int;
	function duplicateLayerWoFrames(layer:TLLayer):TLLayer;
	function getLayerKeyFrames(layer:TLLayer):datatools.ArrayRO<TLKeyFrame>;
	function addKeyFrame(layer:TLLayer, keyFrame:TLKeyFrame):Void;
}