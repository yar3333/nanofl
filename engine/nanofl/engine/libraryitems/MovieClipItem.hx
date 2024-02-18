package nanofl.engine.libraryitems;

import haxe.Json;
import js.lib.Error;
import datatools.ArrayRO;
import datatools.ArrayTools;
import js.lib.Promise;
import nanofl.engine.ILayersContainer;
import nanofl.engine.ITextureItem;
import nanofl.engine.ITimeline;
import nanofl.engine.LayerType;
import nanofl.engine.Library;
import nanofl.engine.ILibraryItem;
import nanofl.engine.elements.Element;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.PointTools;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import stdlib.Debug;
import stdlib.Std;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
using stdlib.Lambda;

class MovieClipItem	extends InstancableItem
	implements ILayersContainer
	implements ITimeline
	implements ITextureItem
	implements ISpriteSheetableItem
	implements IFramedItem
{
	function get_type() return LibraryItemType.movieclip;
	
	public var _layers = new Array<Layer>();
	public var layers(get, never) : ArrayRO<Layer>; public function get_layers() return _layers;
	
	public var autoPlay = true;
	public var loop = true;
	
	public var likeButton = false;
	public var exportAsSpriteSheet = false;
	public var textureAtlas : String;
	
	public static function createWithFrame(namePath:String, ?elements:Array<Element>, layerName="Layer 0") : MovieClipItem
	{
		var item = new MovieClipItem(namePath);
		var layer = new Layer(layerName);
		item.addLayer(layer);
		layer.addKeyFrame(new KeyFrame(elements));
		return item;
	}
	
	public function new(namePath:String)
	{
		super(namePath);
	}
	
	public function addLayer(layer:Layer) LayersTools.addLayer(this, layer);
	
	public function addLayersBlock(layersToAdd:Array<Layer>, ?index:Int) LayersTools.addLayersBlock(this, layersToAdd, index);
	
	public function removeLayer(index:Int) LayersTools.removeLayer(this, index);
	
	public function removeLayerWithChildren(index:Int) return LayersTools.removeLayerWithChildren(this, index);
	
	public function getFramesAt(frameIndex:Int) : Array<Frame> return LayersTools.getFramesAt(this, frameIndex);
	
	public function getTotalFrames() : Int return LayersTools.getTotalFrames(this);
	
	public function clone() : MovieClipItem
	{
		var obj = new MovieClipItem(namePath);
		copyBaseProperties(obj);
		copyProperties(obj);
		return obj;
	}
	
	function copyProperties(obj:MovieClipItem)
	{
		obj._layers = []; for (layer in layers) obj.addLayer(layer.clone());
		obj.likeButton = likeButton;
		obj.autoPlay = autoPlay;
		obj.loop = loop;
		obj.exportAsSpriteSheet = exportAsSpriteSheet;
		obj.textureAtlas = textureAtlas;
	}
	
	public function getIcon()
	{
		if (namePath == Library.SCENE_NAME_PATH) return "custom-icon-scene";
		if (likeButton) return "custom-icon-button";
		return "custom-icon-film";
	}
	
	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>)
	{
		var r = super.createDisplayObject(initFrameIndex, childFrameIndexes);
		if (r != null) return r;
		
		var spriteSheet = TextureItemTools.getSpriteSheet(this);
		if (spriteSheet == null && exportAsSpriteSheet) spriteSheet = asSpriteSheet();
		
		if (spriteSheet == null)
		{
			return !likeButton ? new nanofl.MovieClip(this, initFrameIndex, childFrameIndexes) : new nanofl.Button(this);
		}
		else
		{
			return !likeButton ? new easeljs.display.Sprite(spriteSheet, initFrameIndex) : new nanofl.SpriteButton(spriteSheet);
		}
	}
	
	public function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : Void
	{
		if (exportAsSpriteSheet)
		{
			//Debug.assert(Std.isOfType(dispObj, easeljs.display.Sprite));
		}
		else
		{
			Debug.assert(Std.isOfType(dispObj, nanofl.MovieClip));
			
			var movieClip : nanofl.MovieClip = cast dispObj;
			
			movieClip.removeAllChildren();
			movieClip.alpha = 1.0;
			
			var topElement : Element = null;
			var topElementLayer : Int = null;
			
			var i = layers.length - 1; while (i >= 0)
			{
				for (tweenedElement in layers[i].getTweenedElements(movieClip.currentFrame))
				{
					if (childFrameIndexes == null || childFrameIndexes.length == 0 || childFrameIndexes[0].element != cast tweenedElement.original)
					{
						var obj = tweenedElement.current.createDisplayObject(childFrameIndexes);
						obj.visible = layers[i].type == LayerType.normal;
						movieClip.addChildToLayer(obj, i);
					}
					else
					if (childFrameIndexes != null && childFrameIndexes.length != 0 && childFrameIndexes[0].element == cast tweenedElement.original)
					{
						topElement = tweenedElement.current;
						topElementLayer = i;
					}
				}
				i--;
			}
			
			if (topElement != null)
			{
				movieClip.addChildToLayer(topElement.createDisplayObject(childFrameIndexes), topElementLayer);
			}
		}
	}
	
	var spriteSheet : easeljs.display.SpriteSheet;
	function asSpriteSheet() : easeljs.display.SpriteSheet
	{
		if (spriteSheet == null)
		{
			var builder = new easeljs.utils.SpriteSheetBuilder();
			
			var t = exportAsSpriteSheet;
			exportAsSpriteSheet = false;
			for (i in 0...getTotalFrames())
			{
				var mc = new MovieClip(this, i, null);
				builder.addFrame(mc);
			}
			exportAsSpriteSheet = t;
			
			spriteSheet = builder.build();
		}
		return spriteSheet;
	}
	
	public function getDisplayObjectClassName() return !likeButton ? "nanofl.MovieClip" : "nanofl.Button";
	
	public function preload() : Promise<{}>
	{
		return TextureItemTools.preload(this);
	}
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (item == this) return true;
		
		if (!Std.isOfType(item, MovieClipItem)) return false;
		
		if (item.namePath != namePath) return false;
		
		var mc = (cast item:MovieClipItem);
		
		if (mc.linkedClass != linkedClass) return false;
		if (mc.autoPlay != autoPlay) return false;
		if (mc.loop != loop) return false;
		
		if (!ArrayTools.equ(mc._layers, _layers)) return false;
		
		if ((cast item:MovieClipItem).likeButton != likeButton) return false;
		if ((cast item:MovieClipItem).exportAsSpriteSheet != exportAsSpriteSheet) return false;
		if ((cast item:MovieClipItem).textureAtlas != textureAtlas) return false;
		
		return true;
	}
	
	override public function getNearestPoint(pos:Point) : Point
	{
		var points = [];
		for (layer in layers)
		{
			if (layer.keyFrames.length > 0)
			{
				for (element in layer.keyFrames[0].elements)
				{
					points.push(element.getNearestPoint(pos));
				}
			}
		}
		points.sort(function(a, b)
		{
			return Reflect.compare(PointTools.getDistP(pos, a), PointTools.getDistP(pos, b));
		});
		return points.length > 0 ? points[0] : { x:1e100, y:1e100 };
	}
	
	override public function setLibrary(library:Library)
	{
		super.setLibrary(library);
		for (layer in layers) layer.setLibrary(library);
	}
	
	public function transform(m:Matrix)
	{
		for (layer in layers)
		{
			for (keyFrame in layer.keyFrames)
			{
				for (element in keyFrame.elements)
				{
					element.transform(m);
				}
			}
		}
	}
    
    public static function loadFromJson(namePath:String, baseLibraryUrl:String) : Promise<MovieClipItem>
    {
        return Loader.file(baseLibraryUrl + "/" + namePath + ".json")
                .then(itemJsonStr ->
                {
                    var r = new MovieClipItem(namePath);
                    r.loadPropertiesJson(Json.parse(itemJsonStr));
                    return r;
                });
    }

    #if ide
	function hasDataToSave() return true;
    
    override function saveProperties(xml:XmlBuilder) : Void
    {
        super.saveProperties(xml);

		xml.attr("autoPlay", autoPlay, true);
		xml.attr("loop", loop, true);
		
		xml.attr("likeButton", likeButton, false);
		xml.attr("exportAsSpriteSheet", exportAsSpriteSheet, false);
		xml.attr("textureAtlas", textureAtlas, null);
		
		for (layer in layers) layer.save(xml);
    }

    override function savePropertiesJson(obj:Dynamic) : Void
    {
        super.savePropertiesJson(obj);

        obj.autoPlay = autoPlay ?? true;
		obj.loop = loop ?? true;
		
		obj.likeButton = likeButton ?? false;
		obj.exportAsSpriteSheet = exportAsSpriteSheet ?? false;
		obj.textureAtlas = textureAtlas ?? null;
		
		obj.layers = layers.map(x -> x.saveJson());
    }
    
    override function loadProperties(xml:HtmlNodeElement) : Void
    {
        super.loadProperties(xml);

		var version = xml.getAttribute("version");
		if (version == null || version == "") version = "1.0.0";
		
        autoPlay = xml.getAttr("autoPlay", true);
		loop = xml.getAttr("loop", true);
		
		likeButton = xml.getAttr("likeButton", false);
		exportAsSpriteSheet = xml.getAttr("exportAsSpriteSheet", false);
		textureAtlas = xml.getAttr("textureAtlas", null);

		addLayersBlock
        (
            xml.children.filter(x -> x.name == "layer").map(x -> 
            {
                var layer = new Layer("");
                layer.loadProperties(x, version);
                return layer;
            })
        );
    }
    #end
    
    override function loadPropertiesJson(obj:Dynamic) : Void
    {
        if (obj.type != type) throw new Error("Type of item must be '" + type + "', but '" + obj.type + "' found.");
        
        super.loadPropertiesJson(obj);

        autoPlay = obj.autoPlay;
        loop = obj.loop;
        
        likeButton = obj.likeButton;
        exportAsSpriteSheet = obj.exportAsSpriteSheet;
        textureAtlas = obj.textureAtlas;

		addLayersBlock
        (
            (cast obj.layers : Array<Dynamic>).map(x -> 
            {
                var layer = new Layer("");
                layer.loadPropertiesJson(x, obj.version);
                return layer;
            })
        );
    }
	
	public function toString() return "MovieClipItem(" + namePath + ")";
}