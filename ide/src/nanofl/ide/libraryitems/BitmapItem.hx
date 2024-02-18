package nanofl.ide.libraryitems;

import haxe.crypto.Base64;
import nanofl.engine.Loader;
import nanofl.engine.IPathElement;
import htmlparser.HtmlNodeElement;
import js.lib.Promise;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import stdlib.Debug;

class BitmapItem extends nanofl.engine.libraryitems.BitmapItem
	implements IIdeInstancableItem
{
	override public function clone() : BitmapItem
	{
		var obj : BitmapItem = new BitmapItem(namePath, ext);
		
		obj.ext = ext;
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
	
	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
		var r = new nanofl.Bitmap(this);
		
		r.setBounds(0, 0, image.width, image.height);
		
		return r;
	}
	
	/*override public function equ(item:ILibraryItem) : Bool
	{
		return super.equ(item);
	}*/
	
	public function getFilePathToRunWithEditor() : String 
	{
		return namePath + "." + ext;
	}
	
	public function getLibraryFilePaths() : Array<String>
	{
		return [ namePath + ".*" ];
	}
	
	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String) : IIdeLibraryItem
	{
		log("BitmapItem: publish " + namePath + "; ext = " + ext);

        final imgInfo = getImageForPublish(fileSystem, settings);
        if (imgInfo == null) return clone();

        fileSystem.saveContent
        (
            destLibraryDir + "/" + namePath + ".js",
            'nanofl.libraryFiles ||= {};\n'
          + 'nanofl.libraryFiles["' + namePath + '.' + imgInfo.ext + '"] = "' + imgInfo.dataBase64 + '";'
        );

        var item = clone();
        item.ext = imgInfo.ext;

        return item;
	}

    function getImageForPublish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings) : { ext:String, dataBase64:String }
    {
        if (settings.useTextureAtlases && textureAtlas != null && textureAtlas != "") return null;

        final srcFilePath = library.libraryDir + "/" + namePath + "." + ext;
        if (settings.isConvertImagesIntoJpeg && !nanofl.ide.BitmapItemTools.isTransparent(library, this))
        {
            final destFilePath = fileSystem.getTempFilePath(".jpg");
            final success = new nanofl.ide.MediaConvertor().convertImage(srcFilePath, destFilePath, settings.jpegQuality);
            log("converted '" + namePath + "." + ext + "' => '" + namePath + ".jpg': " + (success ? "OK" : "FAIL"));
            if (success)
            {
                final dataBase64 = getFileContentAsBase64String(fileSystem, destFilePath);
                fileSystem.deleteFile(destFilePath);
                return { ext:"jpg", dataBase64:dataBase64 };
            }
        }

        return { ext:ext, dataBase64:getFileContentAsBase64String(fileSystem, srcFilePath) };
    }

    static function getFileContentAsBase64String(fileSystem:nanofl.ide.sys.FileSystem, filePath:String) : String
    {
        var bytes = fileSystem.getBinary(filePath);
        return Base64.encode(bytes);
    }
	
	public function getUsedSymbolNamePaths() : Array<String> return [ namePath ];
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}