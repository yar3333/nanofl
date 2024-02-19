package nanofl.engine.libraryitems;

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
	
	public var linkage = "";
	
	public function new(namePath:String, ext:String)
	{
		super(namePath);
		this.ext = ext;
	}
	
	public function clone() : SoundItem
	{
		var obj = new SoundItem(namePath, ext);
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
		if ((cast item:SoundItem).linkage != linkage) return false;
		return true;
	}
	
    public function preload() : Promise<{}> return Promise.resolve();

    #if ide
	function hasDataToSave() return linkage != "";

    function saveProperties(xml:XmlBuilder) : Void
    {
		xml.attr("linkage", linkage, "");
		xml.attr("ext", ext, "");
    }

    function savePropertiesJson(obj:Dynamic) : Void
    {
        obj.linkage = linkage ?? "";
        obj.ext = ext ?? "";
    }
    
    function loadProperties(xml:HtmlNodeElement) : Void
    {
		linkage = xml.getAttr("linkage", "");
        ext = xml.getAttr("ext", "");
    }
    #end
    
    function loadPropertiesJson(obj:Dynamic) : Void
    {
        linkage = obj.linkage ?? "";
        ext = obj.ext ?? "";
    }

	public function toString() return "SoundItem(" + namePath + ")";
}
