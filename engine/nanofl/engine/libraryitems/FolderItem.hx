package nanofl.engine.libraryitems;

import js.lib.Promise;
import nanofl.engine.ILibraryItem;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;

class FolderItem extends LibraryItem
{
    function get_type() return LibraryItemType.folder;
	
    public var opened = false;
	
	public function new(namePath:String) super(namePath);
	
	public function clone() : FolderItem
	{
		var obj  = new FolderItem(namePath);
		obj.opened = opened;
		copyBaseProperties(obj);
		return obj;
	}
	
	public function getIcon() return opened ? "custom-icon-folder-open" : "custom-icon-folder-close";
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (!Std.isOfType(item, FolderItem)) return false;
        if (!super.equ(item)) return false;
		return true;
	}
    
    public function preload() : Promise<{}> return Promise.resolve();

    #if ide
	function hasDataToSave() return true;
    
    function saveProperties(xml:XmlBuilder) : Void {}

    function savePropertiesJson(obj:Dynamic) : Void {}
    
    function loadProperties(node:HtmlNodeElement) : Void {}
    #end
    
    function loadPropertiesJson(obj:Dynamic) : Void {}    
	
	public function toString() return "FolderItem(" + namePath + ")";
}