package nanofl.engine.libraryitems;

import nanofl.engine.libraryitems.LibraryItem;
import nanofl.engine.elements.Instance;
import nanofl.engine.geom.Point;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

abstract class InstancableItem extends LibraryItem
{
	public var linkedClass = "";
	
	private function new(namePath:String)
    {
        super(namePath);
    }
    
    override function copyBaseProperties(obj:LibraryItem):Void 
    {
        super.copyBaseProperties(obj);
        (cast obj:InstancableItem).linkedClass = linkedClass;
    }
    
    public function newInstance() : Instance
    {
        stdlib.Debug.assert(library != null, "You must add symbol '" + namePath + "' to library before newInstance() call.");
        
        var r = new Instance(namePath);
        r.setLibrary(library);
        return r;
    }
	
	public abstract function getDisplayObjectClassName() : String;
	
	public function createDisplayObject(params:Dynamic) : easeljs.display.DisplayObject
	{
		#if !ide
		if (linkedClass != "")
		{
			var klass = untyped window[linkedClass];
			if (klass != null) return js.Syntax.code("new klass(this, params)");
			trace("Linkage class '" + linkedClass + "' is not found.");
		}
		#end
		return null;
	}
	
	public function getNearestPoint(pos:Point) : Point return { x:1e100, y:1e100 };
    
    override public function equ(item:ILibraryItem) : Bool
    {
        if (Std.isOfType(item, InstancableItem)) return false;
        if (!super.equ(item)) return false;
        return linkedClass == (cast item : InstancableItem).linkedClass;
    }

    #if ide
    function saveProperties(xml:XmlBuilder) : Void
    {
		xml.attr("linkedClass", linkedClass, "");
    }

    function savePropertiesJson(obj:Dynamic) : Void
    {
        obj.linkedClass = linkedClass ?? "";
    }
    
    function loadProperties(node:HtmlNodeElement) : Void
    {
		linkedClass = node.getAttr("linkedClass", "");
    }
    #end
    
    function loadPropertiesJson(obj:Dynamic) : Void
    {
        linkedClass = obj.linkedClass ?? "";
    }      
}