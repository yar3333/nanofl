package nanofl.engine.libraryitems;

import datatools.ArrayTools;
import datatools.ObjectTools;
import datatools.ArrayRO;
import js.lib.Promise;
import nanofl.engine.ILayersContainer;
import nanofl.engine.ITextureItem;
import nanofl.engine.elements.SpriteFrameElement;
import nanofl.engine.geom.Point;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import stdlib.Debug;
using nanofl.engine.geom.BoundsTools;
using Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class SpriteItem extends InstancableItem
	implements ILayersContainer
	implements ITextureItem
{
	function get_type() return LibraryItemType.sprite;
	
	var frames : Array<SpriteItemFrame>;
	
	// ILayersContainer
	var _layers : Array<Layer>;
	public var layers(get, never) : ArrayRO<Layer>;
	@:noCompletion public function get_layers()
	{
		if (_layers == null)
		{
			var layer = new Layer("auto");
			layer.layersContainer = this;
			for (i in 0...frames.length)
			{
				layer.addKeyFrame(new KeyFrame(1, [ new SpriteFrameElement(this, i) ]));
			}
			_layers = [ layer ];
		}
		return _layers;
	}
	
	// IFramedItem
	public var likeButton = false;
	public var autoPlay = true;
	public var loop = true;
	
	// ITextureItem
	public var textureAtlas : String;
	
	public var spriteSheet(default, null) : easeljs.display.SpriteSheet;
	
	public function new(namePath:String, frames:Array<SpriteItemFrame>)
	{
		super(namePath);
		this.frames = frames;
	}
	
	public function clone() : SpriteItem
	{
		var obj = new SpriteItem(namePath, frames);
		
		obj.likeButton = likeButton;
		obj.autoPlay = autoPlay;
		obj.loop = loop;
		obj.textureAtlas = textureAtlas;
		obj.spriteSheet = spriteSheet;
		
		copyBaseProperties(obj);
		
		return obj;
	}
	
	public function getIcon()
	{
		return "custom-icon-picture";
	}
	
	public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
		
		return TextureItemTools.getSpriteSheet(this) == null
					? ensureSpriteSheet()
					: TextureItemTools.preload(this);
	}
	
	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
		var r = super.createDisplayObject(initFrameIndex, childFrameIndexes);
		if (r != null) return r;
		var spriteSheet = TextureItemTools.getSpriteSheet(this);
		if (spriteSheet == null) spriteSheet = this.spriteSheet;
		
		Debug.assert(spriteSheet != null);
		Debug.assert(spriteSheet.complete);
		var sprite = new easeljs.display.Sprite(spriteSheet);
		sprite.gotoAndStop(initFrameIndex);
		return sprite;
	}
	
	public function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>)
	{
		//stdlib.Debug.assert(Std.isOfType(dispObj, easeljs.display.Sprite));
		//if (childFrameIndexes != null && childFrameIndexes.length > 0 && childFrameIndexes[0].element == this)
		//{
		//	(cast dispObj:easeljs.display.Sprite).gotoAndStop(childFrameIndexes[0].frameIndex);
		//}
	}
	
	function ensureSpriteSheet() : Promise<{}>
	{
		if (spriteSheet == null)
		{
			var images = [];
			for (f in frames)
			{
				if (images.indexOf(f.image) < 0) images.push(f.image);
			}
			
			var data =
			{
				images: images.map(image -> library.realUrl(image)),
				frames: frames.map(f -> [ f.x, f.y, f.width, f.height, images.indexOf(f.image), f.regX, f.regY ])
			};
			
			spriteSheet = new easeljs.display.SpriteSheet(data);
		}
		
		if (!spriteSheet.complete)
		{
			return new Promise((resolve, reject) ->
			{
				spriteSheet.addCompleteEventListener(function(_) resolve(null));
			});
		}
		else
		{
			return Promise.resolve(null);
		}
	}
	
	override public function getNearestPoint(pos:Point) : Point
	{
		if (frames.length == 0) return { x:1e100, y:1e100 };
		
		var frame = frames[0];
		
		var bounds =
		{
			minX: -frame.regX,
			minY: -frame.regY,
			maxX: frame.width  - frame.regX,
			maxY: frame.height - frame.regY
		};
		
		return bounds.getNearestPoint(pos);
	}
	
	public function getDisplayObjectClassName() return !likeButton ? "nanofl.Sprite" : "nanofl.SpriteButton";

    override public function equ(item:ILibraryItem) : Bool
    {
        if (!Std.isOfType(item, SpriteItem)) return false;
        if (!super.equ(item)) return false;
        if (!ArrayTools.equByFunc(frames, (cast item:SpriteItem).frames, (a, b) -> ObjectTools.equFast(a, b))) return false;
        if (!ArrayTools.equ(layers, (cast item:SpriteItem).layers)) return false;
        return true;
    }

    #if ide
	function hasDataToSave() return true;
	
    override function saveProperties(xml:XmlBuilder) : Void
    {
        super.saveProperties(xml);

        xml.attr("likeButton", likeButton, false);
		xml.attr("autoPlay", autoPlay, true);
		xml.attr("loop", loop, true);
		xml.attr("textureAtlas", textureAtlas, null);

		for (frame in frames)
        {
            xml.begin("frame");
            xml.attr("image", frame.image);
            xml.attr("x", frame.x);
            xml.attr("y", frame.y);
            xml.attr("width", frame.width);
            xml.attr("height", frame.height);
            xml.attr("regX", frame.regX);
            xml.attr("regY", frame.regY);
            xml.end();
        }
    }

    override function savePropertiesJson(obj:Dynamic) : Void
    {
        super.savePropertiesJson(obj);

        obj.likeButton = likeButton ?? false;
		obj.autoPlay = autoPlay ?? true;
		obj.loop = loop ?? true;
		obj.textureAtlas = textureAtlas ?? null;

        obj.frames = frames.map(frame ->
        {
            image: frame.image,
            x: frame.x,
            y: frame.y,
            width: frame.width,
            height: frame.height,
            regX: frame.regX,
            regY: frame.regY,
        });
    }
    
    override function loadProperties(xml:HtmlNodeElement) : Void
    {
        super.loadProperties(xml);

		likeButton = xml.getAttr("likeButton", false);
		autoPlay = xml.getAttr("autoPlay", true);
		loop = xml.getAttr("loop", true);
		textureAtlas = xml.getAttr("textureAtlas", null);

        frames = xml.children.map(frameXml ->
        {
            image: frameXml.getAttrString("image"),
            x: frameXml.getAttrInt("x"),
            y: frameXml.getAttrInt("y"),
            width: frameXml.getAttrInt("width"),
            height: frameXml.getAttrInt("height"),
            regX: frameXml.getAttrFloat("regX"),
            regY: frameXml.getAttrFloat("regY"),
        });
    }
    #end
    
    override function loadPropertiesJson(obj:Dynamic) : Void
    {
        super.loadPropertiesJson(obj);

		likeButton = obj.likeButton ?? false;
		autoPlay = obj.autoPlay ?? true;
		loop = obj.loop ?? true;
		textureAtlas = obj.textureAtlas ?? null;

        frames = (cast obj.frames : Array<Dynamic>).map(frameObj ->
        {
            image: frameObj.image,
            x: frameObj.x,
            y: frameObj.y,
            width: frameObj.width,
            height: frameObj.height,
            regX: frameObj.regX,
            regY: frameObj.regY,
        });
    }
	
	public function toString() return "SpriteItem(" + namePath + ")";
}