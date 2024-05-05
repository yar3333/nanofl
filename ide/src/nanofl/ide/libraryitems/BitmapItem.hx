package nanofl.ide.libraryitems;

import js.lib.Set;
import js.lib.Error;
import js.lib.Promise;
import stdlib.Debug;
import haxe.crypto.Base64;
import htmlparser.HtmlNodeElement;
import nanofl.engine.SerializationAsJsTools;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.MediaUtils;

class BitmapItem extends nanofl.engine.libraryitems.BitmapItem
	implements IIdeInstancableItem
{
	override public function clone() : BitmapItem
	{
		var obj : BitmapItem = new BitmapItem(namePath, ext);
		
		obj.textureAtlas = textureAtlas;
		obj.image = image;
		
		copyBaseProperties(obj);
		
		return obj;
	}
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : BitmapItem
	{
		if (itemNode.name != "bitmap") return null;
		
		//var version = itemNode.getAttribute("version");
		//if (version == null || version == "") version = "1.0.0";
		
		var item = new BitmapItem(namePath, itemNode.getAttribute("ext")); 
		item.loadProperties(itemNode);
		return item;
	}
	
	override public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
		return preloadInner();
	}
	
	override public function createDisplayObject(params:Dynamic) : easeljs.display.DisplayObject
	{
		var r = new nanofl.Bitmap(this);
		
		r.setBounds(0, 0, image.width, image.height); // TODO: need this?
		
		return r;
	}
	
	public function getLibraryFilePaths() : Array<String>
	{
		return [ namePath + ".*" ];
	}

	public function getUrl() return library.realUrl(namePath + "." + ext);

    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:FileSystem, destLibraryDir:String) : Dynamic
    {
        return null;
    }
        
	public function publish(fileSystem:FileSystem, mediaUtils:MediaUtils, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
	{
		log("BitmapItem: publish " + namePath + "; ext = " + ext);

        if (settings.useTextureAtlases && textureAtlas != null && textureAtlas != "") return null;

        final srcFilePath = library.libraryDir + "/" + namePath + "." + ext;
        
        if (!settings.supportLocalFileOpen)
        {
            if (settings.isConvertImagesIntoJpeg && !isImageHasAlpha(image))
            {
                final destFilePath = destLibraryDir + "/" + namePath + ".jpg";
                final success = mediaUtils.convertImage(srcFilePath, destFilePath, settings.jpegQuality);
                log("Convert '" + namePath + "." + ext + "' => '" + namePath + ".jpg': " + (success ? "OK" : "FAIL"));
                if (success)
                {
                    var item = clone();
                    item.ext = "jpg";
                    return item;
                }
            }
            
            fileSystem.copyFile(srcFilePath, destLibraryDir + "/" + namePath + "." + ext);
            return clone();
        }
        else
        {
            if (settings.isConvertImagesIntoJpeg && !isImageHasAlpha(image))
            {
                final destFilePath = fileSystem.getTempFilePath(".jpg");
                final success = mediaUtils.convertImage(srcFilePath, destFilePath, settings.jpegQuality);
                log("Convert '" + namePath + "." + ext + "' => '" + namePath + ".jpg': " + (success ? "OK" : "FAIL"));
                if (success)
                {
                    SerializationAsJsTools.save(fileSystem, destLibraryDir, namePath, "data:image/jpeg;base64," + Base64.encode(fileSystem.getBinary(destFilePath)));
                    fileSystem.deleteFile(destFilePath);
                    var item = clone();
                    item.ext = "js";
                    return item;
                }
            }
                
            SerializationAsJsTools.save(fileSystem, destLibraryDir, namePath, "data:" + getImageMimeType() + ";base64," + Base64.encode(fileSystem.getBinary(srcFilePath)));
            var item = clone();
            item.ext = "js";
            return item;
        }
	}

    function getImageMimeType()
    {
        switch (ext.toLowerCase())
        {
            case "png": return "image/png";
            case "jpg" | "jpeg": return "image/jpeg";
            case _: throw new Error("Can't detect MIME type for extension: " + ext);
        }
    }

	public function getUsedSymbolNamePaths() : Set<String> return new Set([ namePath ]);

	static function isImageHasAlpha(image:js.html.ImageElement)
    {
        var canvas : js.html.CanvasElement = cast js.Browser.document.createElement("canvas");
        canvas.width = image.width; 
        canvas.height = image.height; 
        var ctx = canvas.getContext2d();
        ctx.drawImage(image, 0, 0); 
        var data = ctx.getImageData(0, 0, canvas.width, canvas.height);
        var size = data.width * data.height;
        var i = 3; while (i < size)
        {
            if (data.data[i] != 255) return true;
            i += 4;
        }
        return false;
    }

	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.namedLog("BitmapItem", v);
	}
}