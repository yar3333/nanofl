package components.nanofl.movie.timeline;

import htmlparser.HtmlNodeElement;
import nanofl.engine.LayerType;
import datatools.ArrayRO;
import nanofl.engine.elements.Elements;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.DocumentProperties;
import nanofl.ide.editor.Editor;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.navigator.Navigator;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.menu.MenuItem;
import nanofl.ide.undo.document.UndoQueue;

private typedef TLFrame = components.nanofl.movie.timeline.TLFrame;
private typedef TLLayer = components.nanofl.movie.timeline.TLLayer;
private typedef TLKeyFrame = components.nanofl.movie.timeline.TLKeyFrame;

class TimelineAdapterToEditor 
    implements components.nanofl.movie.timeline.ITimelineAdapter
{
	var editor : Editor;
	var undoQueue : UndoQueue;
	var library : IdeLibrary;
	var preferences : Preferences;
	var pathItem : PathItem;
	var navigator : Navigator;
	var properties : DocumentProperties;
	
	public var layers(get, never) : ArrayRO<TLLayer>;
	function get_layers() : ArrayRO<TLLayer> return pathItem.mcItem.layers;
	
	public var editable(get, never) : Bool;
	function get_editable() : Bool return pathItem.mcItem != null; // TODO: group
	
	public var frameIndex(get, set) : Int;
	function get_frameIndex() : Int return pathItem.frameIndex;
	function set_frameIndex(n:Int) : Int { navigator.setFrameIndex(n); return n; }
	
	public var layerIndex(get, set) : Int;
	function get_layerIndex() : Int return pathItem.layerIndex;
	function set_layerIndex(n:Int) : Int { navigator.setLayerIndex(n); return n; }
	
	public var framerate(get, never) : Float;
	function get_framerate() : Float return properties.framerate;
	
	public final xmlLayersTag = "layers";
	
	public function new(editor:Editor, undoQueue:UndoQueue, library:IdeLibrary, preferences:Preferences, pathItem:PathItem, navigator:Navigator, properties:DocumentProperties)
	{
		this.editor = editor;
		this.undoQueue = undoQueue;
		this.library = library;
		this.preferences = preferences;
		this.pathItem = pathItem;
		this.navigator = navigator;
		this.properties = properties;
	}
	
	function getLayerCount() : Int return pathItem.mcItem.layers.length;
	function getLayer(n:Int) : Layer return pathItem.mcItem.layers[n];
	
	public function beginTransaction() undoQueue.beginTransaction({ timeline:true });
	public function commitTransaction() undoQueue.commitTransaction();
	
	public function getLayerContextMenu() : Array<MenuItem> return preferences.storage.getMenu("layerContextMenu");
	public function getFrameContextMenu() : Array<MenuItem> return preferences.storage.getMenu("frameContextMenu");
	
	public function getLibraryItems(namePaths:Array<String>) : Array<IIdeLibraryItem> return namePaths.map(library.getItem);
	public function addNewKeyFrameToLayer(layer:TLLayer) : Void cast(layer, Layer).addKeyFrame(new KeyFrame());
	public function newLayer(name:String, ?type:LayerType) : TLLayer return new Layer(name, type);
    
    public function parseLayer(layerNode:HtmlNodeElement, version:String) : TLLayer
    {
        var layer = new Layer("");
        layer.loadProperties(layerNode, version);
        return layer;
    }
	
	public function onLayerAdded() : Void editor.rebind();
	public function onLayerRemoved() : Void editor.rebind();
	public function onLayerVisibleChange() : Void editor.rebind();
	public function onLayerLockChange() : Void editor.rebind();
	public function onTweenCreated() : Void editor.rebind();
	public function onTweenRemoved() : Void editor.rebind();
	public function onConvertToKeyFrame() : Void editor.rebind();
	public function onFrameRemoved() : Void editor.rebind();
	public function onLayersSelectionChange(indexes:Array<Int>) : Void editor.selectLayers(indexes);
	
	public function getTotalFrames() : Int return pathItem.getTotalFrames();
	
	public function addLayersBlock(layersToAdd:ArrayRO<TLLayer>, ?index:Int) : Void 
	{
		pathItem.mcItem.addLayersBlock((cast layersToAdd : Array<Layer>), index);
	}
	
	public function removeLayer(index:Int) : Void 
	{
		pathItem.mcItem.removeLayer(index);
	}
	
	public function addLayer(layer:TLLayer) : Void 
	{
		pathItem.mcItem.addLayer((cast layer:Layer));
	}
	
	public function getNamePaths(keyFrame:TLKeyFrame) : Array<String> 
	{
		return Elements.getUsedSymbolNamePaths((cast keyFrame:KeyFrame).elements);
	}
	
	public function getLayerNestLevel(layer:TLLayer) : Int
	{
		return (cast layer:Layer).getNestLevel(pathItem.mcItem.layers);
	}
	
	public function duplicateLayerWoFrames(layer:TLLayer) : TLLayer
	{
		return (cast layer:Layer).duplicate([], null);
	}
	
	public function getLayerKeyFrames(layer:TLLayer) : ArrayRO<TLKeyFrame>
	{
		return (cast layer:Layer).keyFrames;
	}
	
	public function addKeyFrame(layer:TLLayer, keyFrame:TLKeyFrame) : Void
	{
		(cast layer:Layer).addKeyFrame((cast keyFrame:KeyFrame));
	}
}