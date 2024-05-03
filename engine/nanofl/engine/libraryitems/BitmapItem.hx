package nanofl.engine.libraryitems;

import js.lib.Error;
import js.lib.Promise;
import js.html.ImageElement;
import stdlib.Debug;
import nanofl.engine.ITextureItem;
import nanofl.engine.ILibraryItem;
import nanofl.engine.geom.Point;
using nanofl.engine.geom.BoundsTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class BitmapItem extends InstancableItem 
    implements ITextureItem
    implements ISpritableItem
{
	function get_type() return LibraryItemType.bitmap;
	
    public var ext : String;
	public var textureAtlas : String;
	
	public var image(default, null) : ImageElement;

    public var spriteSheet(get, never) : easeljs.display.SpriteSheet;
	
	public function new(namePath:String, ext:String)
	{
		super(namePath);
		this.ext = ext;
	}
	
	public function clone() : BitmapItem
	{
		var obj : BitmapItem = new BitmapItem(namePath, ext);
		
		obj.ext = ext;
		obj.textureAtlas = textureAtlas;
		obj.image = image;
		
		copyBaseProperties(obj);
		
		return obj;
	}
	
	public function getIcon() return "custom-icon-picture";
	
	public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
		
		return TextureAtlasTools.getSpriteSheet(this) == null
						? preloadInner()
						: Promise.resolve(null);
	}

    function preloadInner() : Promise<{}>
    {
        #if ide
        return Loader.image(library.realUrl(namePath + "." + ext)).then(img -> { image = img; return null; });
        #else
        if (textureAtlas != null && textureAtlas != "") return Promise.resolve(null);
        final imagePromise = ext == "js"
                    ? SerializationAsJsTools.load(library, namePath, true).then((dataUri:String) -> Loader.image(dataUri))
                    : Loader.image(library.realUrl(namePath + "." + ext));
        return imagePromise.then(img -> { image = img; return null; });
        #end
    }
	
	override public function createDisplayObject(params:Dynamic) : easeljs.display.DisplayObject
	{
		var r = super.createDisplayObject(params);
		
		if (r == null)
		{
			r = spriteSheet == null
				? new nanofl.Bitmap(this)
				: new nanofl.Sprite(this, null);
		}
		
		r.setBounds(0, 0, image.width, image.height);
		
		return r;
	}

    function get_spriteSheet() : easeljs.display.SpriteSheet
	{
        #if ide 
        return null;
        #else
        return TextureAtlasTools.getSpriteSheet(this);
        #end
    }
	
	public function getDisplayObjectClassName() return "nanofl.Bitmap";
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (!Std.isOfType(item, BitmapItem)) return false;
        if (!super.equ(item)) return false;
		if ((cast item:BitmapItem).ext != ext) return false;
		if ((cast item:BitmapItem).textureAtlas != textureAtlas) return false;
		return true;
	}
	
	override public function getNearestPoint(pos:Point) : Point
	{
		var bounds = { minX:0.0, minY:0.0, maxX:image.width+0.0, maxY:image.height+0.0 };
		return bounds.getNearestPoint(pos);
	}

    #if ide
	function hasDataToSave()
    {
        return this.linkedClass != null && this.linkedClass != ""
            || textureAtlas != null && textureAtlas != "";
    }
    
    override function saveProperties(xml:XmlBuilder) : Void
    {
        super.saveProperties(xml);
		xml.attr("ext", ext, null);
		xml.attr("textureAtlas", textureAtlas, null);
    }

    override function savePropertiesJson(obj:Dynamic) : Void
    {
        super.savePropertiesJson(obj);
		obj.ext = ext ?? null;
		obj.textureAtlas = textureAtlas ?? null;
    }
    
    override function loadProperties(node:HtmlNodeElement) : Void
    {
        super.loadProperties(node);
        ext = node.getAttr("ext", null);
        textureAtlas = node.getAttr("textureAtlas", null);
    }
    #end
    
    override function loadPropertiesJson(obj:Dynamic) : Void
    {
        if (obj.type != type) throw new Error("Type of item must be '" + type + "', but '" + obj.type + "' found.");
        
        super.loadPropertiesJson(obj);
        ext = obj.ext ?? null;
        textureAtlas = obj.textureAtlas ?? null;
    }
        
	public function toString() return "BitmapItem(" + namePath + ")";
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.trace("", Reflect.isFunction(v) ? v() : v);
	}
}