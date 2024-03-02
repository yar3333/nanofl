package nanofl.engine.libraryitems;

import js.lib.Error;
import js.lib.Promise;
import nanofl.engine.ILibraryItem;
import nanofl.engine.geom.Point;
import js.html.VideoElement;
import stdlib.Debug;
using nanofl.engine.geom.BoundsTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class VideoItem extends InstancableItem
{
	function get_type() return LibraryItemType.bitmap;
	
    public var ext : String;

    public var autoPlay = true;
    public var loop = true;
	
	public var video(default, null) : VideoElement;
	
	public function new(namePath:String, ext:String)
	{
		super(namePath);
		this.ext = ext;
	}
	
	public function clone() : VideoItem
	{
		var obj : VideoItem = new VideoItem(namePath, ext);
		
		obj.ext = ext;
		obj.video = video;
		
		copyBaseProperties(obj);
		
		return obj;
	}
	
	public function getIcon() return "custom-icon-picture";
	
	public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
        return Loader.video(library.realUrl(namePath + "." + ext)).then(vid -> { video = vid; return null; });
    }

	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
		var r = super.createDisplayObject(initFrameIndex, childFrameIndexes);
		
		if (r == null)
		{
			r =  new nanofl.Video(this);
		}
		
		r.setBounds(0, 0, video.videoWidth, video.videoHeight);
		
		return r;
	}
	
	public function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>)
	{
		Debug.assert(Std.isOfType(dispObj, nanofl.Video));
		(cast dispObj:nanofl.Video).video = (cast video.cloneNode() : VideoElement);
		(cast dispObj:nanofl.Video).setBounds(0, 0, video.videoWidth, video.videoHeight);
	}
	
	public function getDisplayObjectClassName() return "nanofl.Bitmap";
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (!Std.isOfType(item, VideoItem)) return false;
        if (!super.equ(item)) return false;
		if ((cast item:VideoItem).ext != ext) return false;
		if ((cast item:VideoItem).autoPlay != autoPlay) return false;
		if ((cast item:VideoItem).loop != loop) return false;
		return true;
	}
	
	override public function getNearestPoint(pos:Point) : Point
	{
		var bounds = { minX:0.0, minY:0.0, maxX:video.videoWidth+0.0, maxY:video.videoHeight+0.0 };
		return bounds.getNearestPoint(pos);
	}

    #if ide
	function hasDataToSave() return true;
    
    override function saveProperties(xml:XmlBuilder) : Void
    {
        super.saveProperties(xml);
		xml.attr("ext", ext, null);
		xml.attr("autoPlay", autoPlay, true);
		xml.attr("loop", loop, true);
    }

    override function savePropertiesJson(obj:Dynamic) : Void
    {
        super.savePropertiesJson(obj);
		obj.ext = ext ?? null;
        obj.autoPlay = autoPlay ?? true;
		obj.loop = loop ?? true;
    }
    
    override function loadProperties(node:HtmlNodeElement) : Void
    {
        super.loadProperties(node);
        ext = node.getAttr("ext", null);
        autoPlay = node.getAttr("autoPlay", true);
		loop = node.getAttr("loop", true);
    }
    #end
    
    override function loadPropertiesJson(obj:Dynamic) : Void
    {
        if (obj.type != type) throw new Error("Type of item must be '" + type + "', but '" + obj.type + "' found.");
        
        super.loadPropertiesJson(obj);
        ext = obj.ext ?? null;
        autoPlay = obj.autoPlay;
        loop = obj.loop;
    }
        
	public function toString() return "VideoItem(" + namePath + ")";
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}