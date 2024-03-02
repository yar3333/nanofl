package nanofl.ide.libraryitems;

import haxe.Json;
import nanofl.engine.SerializationAsJsTools;
import nanofl.ide.sys.FileSystem;
import nanofl.engine.IPathElement;
import htmlparser.HtmlNodeElement;
import js.lib.Promise;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import stdlib.Debug;

class MeshItem extends nanofl.engine.libraryitems.MeshItem
	implements IIdeInstancableItem
{
	override public function clone() : MeshItem
    {
        var obj = new MeshItem(namePath, ext, originalExt);
        
        obj.textureAtlas = textureAtlas;
        obj.renderAreaSize = renderAreaSize;
        obj.loadLights = loadLights;
        
        obj.scene = scene != null ? cast scene.clone(true) : null;
        obj.boundingRadius = boundingRadius;
        obj.textureFiles = textureFiles;
        
        copyBaseProperties(obj);
        
        return obj;
    }
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : MeshItem
    {
        if (itemNode.name != "mesh") return null;
        
        //var version = itemNode.getAttribute("version");
        //if (version == null || version == "") version = "1.0.0";
        
        var item = new MeshItem(namePath, itemNode.getAttribute("ext"), itemNode.getAttribute("originalExt"));
        item.loadProperties(itemNode);
        return item;
    } 
	
	override public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
        return preloadInner();
	}
        
	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
    {
        var r = new nanofl.Mesh(this);
        
        //r.setBounds(0, 0, image.width, image.height);
        
        return r;
    }
	
	public function getFilePathToRunWithEditor() : String 
    {
        return originalExt != null && originalExt != ""
            ? namePath + "." + originalExt
            : namePath + "." + ext;
    }
        
	public function getLibraryFilePaths() : Array<String>
    {
        return [ namePath + ".*" ].concat(textureFiles);
    }
        
    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String) : Dynamic
    {
        return null;
    }
    
    public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
    {
        log("MeshItem publish: " + namePath + "; textureFiles =\n\t" + textureFiles.join("\n\t"));
        
        if (ext == "gltf")
        {
            SerializationAsJsTools.save(fileSystem, destLibraryDir, namePath, Json.parse(fileSystem.getContent(library.libraryDir + "/" + namePath + "." + ext)));
        }

        fileSystem.copyLibraryFiles(library.libraryDir, textureFiles, destLibraryDir);

        return clone();
    }
        
	public function getUsedSymbolNamePaths() : Array<String> return [ namePath ];

    // for BlenderLoaderPlugin
    public static function load(namePath:String, originalExt:String, files:Map<String, nanofl.ide.filesystem.CachedFile>) : MeshItem
    {
        var xmlFile = files.get(namePath + ".xml");
        if (xmlFile != null && xmlFile.xml != null && xmlFile.xml.name == "mesh")
        {
            var r = new MeshItem(namePath, "gltf", originalExt);
            
            r.loadProperties(xmlFile.xml);
            files.remove(xmlFile.relativePath);
            
            var dataFileName = namePath + "." + r.ext;
            if (!files.exists(dataFileName)) return null;
            
            excludeDataFileAndRelatedFiles(files.get(dataFileName), files);
            
            return r;
        }
        
        if (files.exists(namePath + ".gltf"))
        {
            var file = files.get(namePath + ".gltf");
            log("Mesh " + namePath + ".gltf loaded:");
            log(file.json);
            if (!file.json.scenes) return null;
            
            excludeDataFileAndRelatedFiles(file, files);
            
            return new MeshItem(namePath, "gltf", originalExt);
        }
        
        return null;
    }

	static function excludeDataFileAndRelatedFiles(dataFile:nanofl.ide.filesystem.CachedFile, files:Map<String, nanofl.ide.filesystem.CachedFile>)
    {
        // switch (haxe.io.Path.extension(dataFile.path))
        // {
        //     case "json":
        //         for (filePath in getTextureFiles(dataFile.path, dataFile.json)) files.get(filePath).exclude();
        // }
        files.remove(dataFile.relativePath);
    }

	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}