package nanofl.ide.libraryitems;

import htmlparser.HtmlNodeElement;
import nanofl.ide.libraryitems.IIdeLibraryItem;

class VideoItem extends nanofl.engine.libraryitems.VideoItem
	implements IIdeInstancableItem
{
	override public function clone() : VideoItem
	{
		var obj : VideoItem = new VideoItem(namePath, ext);
		
		obj.autoPlay = autoPlay;
		obj.loop = loop;
		obj.video = cast video.cloneNode();
		
		copyBaseProperties(obj);
		
		return obj;
	}
	
	public static function parse(namePath:String, xml:HtmlNodeElement) : VideoItem
	{
		if (xml.name != "video") return null;
		
		//var version = xml.getAttribute("version");
		//if (version == null || version == "") version = "1.0.0";
		
		var item = new VideoItem(namePath, xml.getAttribute("ext")); 
		item.loadProperties(xml);
		return item;
	}
	
	public function getFilePathToRunWithEditor() : String 
	{
		return namePath + "." + ext;
	}
	
	public function getLibraryFilePaths() : Array<String>
	{
		return [ namePath + ".*" ];
	}

	public function getUrl() return library.realUrl(namePath + "." + ext);

    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String) : Dynamic
    {
        return null;
    }
        
	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
	{
		log("VideoItem: publish " + namePath + "; ext = " + ext);

        final srcFilePath = library.libraryDir + "/" + namePath + "." + ext;
        final destFilePath = destLibraryDir + "/" + namePath + "." + ext;
        
        fileSystem.copyFile(srcFilePath, destFilePath);

        return clone();
	}

	public function getUsedSymbolNamePaths() : Array<String> return [ namePath ];

	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}