package nanofl.ide.timeline;

import js.lib.Set;
import htmlparser.HtmlNodeElement;
import datatools.ArrayRO;
import nanofl.engine.elements.Elements;
import nanofl.engine.LayerType;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.DocumentProperties;
import nanofl.ide.editor.Editor;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.navigator.Navigator;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.ui.menu.MenuItem;
import nanofl.ide.undo.document.UndoQueue;

class EditorTimeline
{
	var editor : Editor;
	var undoQueue : UndoQueue;
	var library : IdeLibrary;
	var preferences : Preferences;
	var pathItem : PathItem;
	var navigator : Navigator;
	var properties : DocumentProperties;
	
	public var layers(get, never) : ArrayRO<Layer>;
	function get_layers() : ArrayRO<Layer> return pathItem.mcItem.layers;
	
	public var editable(get, never) : Bool;
	function get_editable() : Bool return !pathItem.mcItem.isGroup();
	
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
	public function addNewKeyFrameToLayer(layer:Layer) : Void cast(layer, Layer).addKeyFrame(new KeyFrame());
	public function newLayer(name:String, ?type:LayerType) : Layer return new Layer(name, type);
	
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
	
	public function addLayersBlock(layersToAdd:ArrayRO<Layer>, ?index:Int) : Void 
	{
		pathItem.mcItem.addLayersBlock(layersToAdd, index);
	}
	
	public function removeLayer(index:Int) : Void 
	{
		pathItem.mcItem.removeLayer(index);
	}
	
	public function addLayer(layer:Layer) : Void 
	{
		pathItem.mcItem.addLayer(layer);
	}
	
	public function getNamePaths(keyFrame:KeyFrame) : Set<String> 
	{
		return Elements.getUsedSymbolNamePaths(keyFrame.elements);
	}
	
	public function getLayerNestLevel(layer:Layer) : Int
	{
		return layer.getNestLevel(pathItem.mcItem.layers);
	}
	
	public function duplicateLayerWoFrames(layer:Layer) : Layer
	{
		return layer.duplicate([], null);
	}
	
	public function getLayerKeyFrames(layer:Layer) : ArrayRO<KeyFrame>
	{
		return layer.keyFrames;
	}
	
	public function addKeyFrame(layer:Layer, keyFrame:KeyFrame) : Void
	{
		layer.addKeyFrame(keyFrame);
	}
}