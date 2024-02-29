package nanofl.engine.libraryitems;

import js.html.Audio;
import js.Browser;
import js.lib.Promise;
import nanofl.engine.ILibraryItem;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class SoundItem extends LibraryItem
{
	function get_type() return LibraryItemType.sound;
	
	public var ext : String;
	
	public var loop = false;
	public var linkage = "";

    public var audio(default, null) : Audio;
	
	public function new(namePath:String, ext:String)
	{
		super(namePath);
		this.ext = ext;
	}
	
	public function clone() : SoundItem
	{
		var obj = new SoundItem(namePath, ext);
		obj.loop = loop;
		obj.linkage = linkage;
		copyBaseProperties(obj);
		return obj;
	}
	
	public function getIcon() return "custom-icon-sound";
	
	public function getUrl() return library.realUrl(namePath + "." + ext);
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (item.namePath != namePath) return false;
		if (!Std.isOfType(item, SoundItem)) return false;
		if ((cast item:SoundItem).ext != ext) return false;
		if ((cast item:SoundItem).loop != loop) return false;
		if ((cast item:SoundItem).linkage != linkage) return false;
		return true;
	}
	
    public function preload() : Promise<{}>
    {
        stdlib.Debug.assert(linkage != null && linkage != "");

        return ext.toLowerCase() == "js"
            ? SerializationAsJsTools.load(library, namePath, true).then(dataUri -> preloadInner(dataUri))
            : preloadInner(library.realUrl(namePath + "." + ext));
    }

    private function preloadInner(uri:String) : Promise<{}>
    {
        return new Promise((resolve, reject) ->
        {
            audio = new Audio();
            audio.addEventListener("canplay", () -> resolve(null));
            audio.addEventListener("error", e ->
            {
                Browser.console.warn("Error loading sound " + namePath, e);
                resolve(null);
            });
            audio.src = uri;
            audio.loop = loop;
        });
    }

    @:keep
    public function play() : Audio
    {
        stdlib.Debug.assert(audio != null);

        var r : Audio = cast audio.cloneNode();
        r.play();
        return r;
    }

    #if ide
	function hasDataToSave() return linkage != "";

    function saveProperties(xml:XmlBuilder) : Void
    {
		xml.attr("loop", loop, false);
		xml.attr("linkage", linkage, "");
		xml.attr("ext", ext, "");
    }

    function savePropertiesJson(obj:Dynamic) : Void
    {
        obj.loop = loop ?? false;
        obj.linkage = linkage ?? "";
        obj.ext = ext ?? "";
    }
    
    function loadProperties(xml:HtmlNodeElement) : Void
    {
		loop = xml.getAttr("loop", false);
		linkage = xml.getAttr("linkage", "");
        ext = xml.getAttr("ext", "");
    }
    #end
    
    function loadPropertiesJson(obj:Dynamic) : Void
    {
        loop = obj.loop ?? false;
        linkage = obj.linkage ?? "";
        ext = obj.ext ?? "";
    }

	public function toString() return "SoundItem(" + namePath + ")";
}
