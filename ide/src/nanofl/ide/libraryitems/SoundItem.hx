package nanofl.ide.libraryitems;

import htmlparser.HtmlNodeElement;
import nanofl.ide.libraryitems.IIdeLibraryItem;

class SoundItem extends nanofl.engine.libraryitems.SoundItem
	implements IIdeLibraryItem
{
	override public function clone() : SoundItem
	{
		var obj = new SoundItem(namePath, ext);
        obj.loop = loop;
		obj.linkage = linkage;
        obj.audio = cast audio?.cloneNode();
		copyBaseProperties(obj);
		return obj;
	}
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : SoundItem
	{
		if (itemNode.name != "sound") return null;
		
		var r = new SoundItem(namePath, itemNode.getAttribute("ext"));
        r.loadProperties(itemNode);

        return r;
	}
	
    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String) : Dynamic
    {
        var destFile = destLibraryDir + "/" + namePath + ".ogg";
        if (!fileSystem.exists(destFile)) return null;
        return { size:fileSystem.getSize(destFile), mtime:fileSystem.getLastModified(destFile).getTime(), content:fileSystem.getBinary(destFile) };
    }

	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
	{
        var srcFile = library.libraryDir + "/" + namePath + "." + ext;
        var destFile = destLibraryDir + "/" + namePath + ".ogg";
        new nanofl.ide.MediaConvertor().convertAudio(srcFile, destFile, settings.audioQuality);

        if (fileSystem.exists(destFile) && savedData != null)
        {
            if (fileSystem.getSize(destFile) == savedData.size && fileSystem.getLastModified(srcFile).getTime() <= savedData.mtime)
            {
                fileSystem.saveBinary(destFile, savedData.content);
            }
        }

        var r = clone();
        r.ext = "ogg";
        return r;
	}
	
	public function getFilePathToRunWithEditor() : String return null;
	
	public function getLibraryFilePaths() : Array<String> return [];
}
