package nanofl.ide.libraryitems;

import haxe.Json;
import nanofl.engine.SerializationAsJsTools;
import nanofl.ide.sys.FileSystem;
import htmlparser.HtmlNodeElement;
import js.lib.Promise;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import stdlib.Debug;

class MeshItem extends nanofl.engine.libraryitems.MeshItem
	implements IIdeInstancableItem
{
	override public function clone() : MeshItem
    {
        var obj = new MeshItem(namePath);
        
        obj.textureAtlas = textureAtlas;
        obj.renderAreaSize = renderAreaSize;
        obj.loadLights = loadLights;
        
        obj.scene = scene != null ? cast scene.clone(true) : null;
        obj.boundingRadius = boundingRadius;
        
        copyBaseProperties(obj);
        
        return obj;
    }
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : MeshItem
    {
        if (itemNode.name != "mesh") return null;
        
        //var version = itemNode.getAttribute("version");
        //if (version == null || version == "") version = "1.0.0";
        
        var item = new MeshItem(namePath);
        item.loadProperties(itemNode);
        return item;
    } 
	
	override public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
        return preloadInner();
	}
        
	override public function createDisplayObject() : easeljs.display.DisplayObject
    {
        return new nanofl.Mesh(this);
    }
	
	public function getFilePathToRunWithEditor() : String 
    {
        // TODO: blend if exists
        return namePath + ".gltf";
    }
        
	public function getLibraryFilePaths() : Array<String>
    {
        return [ namePath + ".*" ];
    }
        
    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String) : Dynamic
    {
        return null;
    }
    
    public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
    {
        log("MeshItem publish: " + namePath);
        
        SerializationAsJsTools.save(fileSystem, destLibraryDir, namePath, Json.parse(fileSystem.getContent(library.libraryDir + "/" + namePath + ".gltf")));

        return clone();
    }
    
	public function getUsedSymbolNamePaths() : Array<String> return [ namePath ];

	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}