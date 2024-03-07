package nanofl.engine.libraryitems;

import haxe.Json;
import js.lib.Error;
import datatools.ArrayRO;
import datatools.ArrayTools;
import js.lib.Promise;
import easeljs.display.SpriteSheet;
import nanofl.engine.ILayersContainer;
import nanofl.engine.ITextureItem;
import nanofl.engine.ITimeline;
import nanofl.engine.Library;
import nanofl.engine.ILibraryItem;
import nanofl.engine.elements.Element;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.PointTools;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import stdlib.Std;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class MovieClipItem	extends InstancableItem
	implements ILayersContainer
	implements ITimeline
	implements ITextureItem
    implements ISpritableItem
{
	function get_type() return LibraryItemType.movieclip;
	
	public var _layers = new Array<Layer>();
	public var layers(get, never) : ArrayRO<Layer>; function get_layers() return _layers;
	
	public var autoPlay = true;
	public var loop = true;
	
	public var likeButton = false;
	public var textureAtlas : String;

    public var relatedSound : String;

    /**
        Build `SpriteSheet` on-the-fly (every frame of movie clip become bitmap in SpriteSheet) on first DisplayObject creating.
        Fields `exportAsSprite` and `spriteSheet` are ignored if this movie clip included in texture atlas.
    **/
	public var exportAsSprite = false;
    
    var _spriteSheet : easeljs.display.SpriteSheet = null;
    public var spriteSheet(get, never) : easeljs.display.SpriteSheet;
	
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
		obj.exportAsSprite = exportAsSprite;
		obj.textureAtlas = textureAtlas;
		obj.relatedSound = relatedSound;
	}
	
	public function getIcon()
	{
		if (namePath == Library.SCENE_NAME_PATH) return "custom-icon-scene";
		if (likeButton) return "custom-icon-button";
		return "custom-icon-film";
	}
	
	override public function createDisplayObject()
	{
		var r = super.createDisplayObject();
		if (r != null) return r;
		
        return switch(spriteSheet == null)
		{
            case true:  !likeButton ? new nanofl.MovieClip(this) : new nanofl.Button(this);
            case false: !likeButton ? new nanofl.Sprite(this)    : new nanofl.SpriteButton(this);
		}
	}

    function get_spriteSheet() : easeljs.display.SpriteSheet
	{
        #if ide return null; #end
		if (_spriteSheet == null)
		{
            _spriteSheet = TextureAtlasTools.getSpriteSheet(this);
            if (exportAsSprite && _spriteSheet == null)
            {
                var builder = new easeljs.utils.SpriteSheetBuilder();
                
                var t = exportAsSprite;
                exportAsSprite = false;
                for (i in 0...getTotalFrames())
                {
                    var mc = new MovieClip(this, i);
                    builder.addFrame(mc);
                }
                exportAsSprite = t;
                
                _spriteSheet = builder.build();
            }
		}
		return _spriteSheet;
	}
	
	public function getDisplayObjectClassName()
    {
        return switch(exportAsSprite)
        {
            case false: !likeButton ? "nanofl.MovieClip" : "nanofl.Button";
            case true:  !likeButton ? "nanofl.Sprite"    : "nanofl.SpriteButton";
        }
    }
	
	public function preload() : Promise<{}>
	{
		return Promise.resolve(null);
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
		if ((cast item:MovieClipItem).exportAsSprite != exportAsSprite) return false;
		if ((cast item:MovieClipItem).textureAtlas != textureAtlas) return false;
		if ((cast item:MovieClipItem).relatedSound != relatedSound) return false;
		
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
		points.sort((a, b) -> Reflect.compare(PointTools.getDistP(pos, a), PointTools.getDistP(pos, b)));
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
		xml.attr("exportAsSprite", exportAsSprite, false);
		xml.attr("textureAtlas", textureAtlas, null);
		xml.attr("relatedSound", relatedSound, "");
		
		for (layer in layers) layer.save(xml);
    }

    override function savePropertiesJson(obj:Dynamic) : Void
    {
        super.savePropertiesJson(obj);

        obj.autoPlay = autoPlay ?? true;
		obj.loop = loop ?? true;
		
		obj.likeButton = likeButton ?? false;
		obj.exportAsSprite = exportAsSprite ?? false;
		obj.textureAtlas = textureAtlas ?? null;
		obj.relatedSound = relatedSound ?? "";
		
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
		exportAsSprite = xml.getAttr("exportAsSprite", false);
		textureAtlas = xml.getAttr("textureAtlas", null);
		relatedSound = xml.getAttr("relatedSound", "");

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
        exportAsSprite = obj.exportAsSprite;
        textureAtlas = obj.textureAtlas;
        relatedSound = obj.relatedSound ?? "";

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