package nanofl.engine.libraryitems;

import js.lib.Promise;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
#end

abstract class LibraryItem
	implements ILibraryItem
{
    public var type(get, never) : LibraryItemType;
	abstract function get_type() : LibraryItemType;
	
	public var library(default, null) : Library;
	
	//@:allow(nanofl.engine.Library.renameItemInner)
	//@:allow(nanofl.engine.Library.setState)
	public var namePath : String;
	
	function new(namePath:String)
	{
		this.namePath = namePath;
	}
	
	public abstract function getIcon() : String;
	
	function copyBaseProperties(obj:LibraryItem) : Void
	{
		obj.library = library;
		obj.namePath = namePath;
	}
	
    public abstract function clone() : LibraryItem;
	
	public abstract function preload() : Promise<{}>;
	
	//@:allow(nanofl.engine.Library)
	public function setLibrary(library:Library)
	{
		this.library = library;
	}
	
	public function duplicate(newNamePath:String) : LibraryItem
	{
		var item = clone();
		item.namePath = newNamePath;
		if (library != null) library.addItem(item);
		return item;
	}
	
	public function remove()
	{
		if (library != null) library.removeItem(namePath);
	}
	
	public function equ(item:ILibraryItem) : Bool
	{
        return namePath == item.namePath;
    }

    public static function loadFromJson(namePath:String, obj:{ type:String }) : ILibraryItem
    {
        var item : ILibraryItem = switch (LibraryItemType.createByName(obj.type))
        {
            case bitmap: new BitmapItem(namePath, null);
            case folder: null;
            case font: new FontItem(namePath);
            case mesh: new MeshItem(namePath, null, null);
            case movieclip: new MovieClipItem(namePath);
            case sound: new SoundItem(namePath, null);
        };
        if (item == null) return null;
        item.loadPropertiesJson(obj);
        return item;
    }
    
    #if ide
    abstract function hasDataToSave() : Bool;

	public function save(fileSystem:nanofl.ide.sys.FileSystem)
	{
		var xmlPath = library.libraryDir + "/" + namePath + ".xml";
		
		if (hasDataToSave())
		{
			var out = new XmlBuilder();
			saveToXml(out);
			fileSystem.saveContent(xmlPath, out.toString());
		}
		else
		{
			fileSystem.deleteFile(xmlPath);
		}
	}
    
    // public function save(fileSystem:nanofl.ide.sys.FileSystem) : Void
    // {
    //     var xmlPath = library.libraryDir + "/" + namePath + ".xml";
	//     var jsonPath = library.libraryDir + "/" + namePath + ".json";
        
    //     if (hasDataToSave())
    //     {
    //         fileSystem.saveContent(xmlPath, jsonmod.Json.encode(saveToJson()));
    //     }
    //     else
    //     {
    //         fileSystem.deleteFile(jsonPath);
    //     }

    //     fileSystem.deleteFile(xmlPath);        
    // }
    
    public final function saveToXml(xml:XmlBuilder)
    {
        xml.begin(type.getName()).attr("version", Version.document);
        saveProperties(xml);
        xml.end();
    }
    
    public final function saveToJson() : { type:String }
    {
        var obj = { type:type.getName(), version:Version.document };
        savePropertiesJson(obj);
        return obj;
    }

    abstract function saveProperties(xml:XmlBuilder) : Void;
    abstract function savePropertiesJson(obj:Dynamic) : Void;
    
    abstract function loadProperties(node:HtmlNodeElement) : Void;
    #end

    public abstract function loadPropertiesJson(obj:Dynamic) : Void;
    
    public abstract function toString() : String;
}
