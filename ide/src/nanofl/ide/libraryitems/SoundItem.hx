package nanofl.ide.libraryitems;

import haxe.crypto.Base64;
import nanofl.engine.SerializationAsJsTools;
import js.Browser;
import htmlparser.HtmlNodeElement;
import nanofl.ide.libraryitems.IIdeLibraryItem;

class SoundItem extends nanofl.engine.libraryitems.SoundItem
	implements IIdeLibraryItem
{
	override public function clone() : SoundItem
	{
		var obj = new SoundItem(namePath, ext);
		obj.linkage = linkage;
		copyBaseProperties(obj);
		return obj;
	}
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : SoundItem
	{
		if (itemNode.name != "sound") return null;
		
		var r = new SoundItem(namePath, itemNode.getAttribute("ext"));
        r.loadProperties(itemNode);

        if (r.ext == null || r.ext == "")
        {
            Browser.console.warn("SoundItem.parse: ext is empty | " + namePath);
            r.ext = "wav";
        }

        return r;
	}
	
	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String) : IIdeLibraryItem
	{
        var srcFile = library.libraryDir + "/" + namePath + "." + ext;
        var destFile = destLibraryDir + "/" + namePath + ".ogg";
        if (!fileSystem.exists(destFile))
        {
            new nanofl.ide.MediaConvertor().convertAudio(srcFile, destFile, settings.audioQuality);
        }
        else
        {
            var srcTime = fileSystem.getLastModified(srcFile);
            var destTime = fileSystem.getLastModified(destFile);
            if (srcTime.getTime() > destTime.getTime())
            {
                new nanofl.ide.MediaConvertor().convertAudio(srcFile, destFile, settings.audioQuality);
            }
            else
            {
                var tempFile = fileSystem.getTempFilePath(".ogg");
                new nanofl.ide.MediaConvertor().convertAudio(srcFile, tempFile, settings.audioQuality);
                if (fileSystem.getSize(srcFile) != fileSystem.getSize(tempFile))
                {
                    fileSystem.copyFile(tempFile, destFile);
                }
                fileSystem.deleteFile(tempFile);
            }
        }

        if (!settings.supportLocalFileOpen)
        {
            var r = clone();
            r.ext = "ogg";
            return r;
        }

        SerializationAsJsTools.save(fileSystem, destLibraryDir, namePath, "data:audio/ogg;base64," + Base64.encode(fileSystem.getBinary(destFile)));
        fileSystem.deleteFile(destFile);
        var r = clone();
        r.ext = "js";
        return r;
	}
	
	/*override public function equ(item:ILibraryItem) : Bool
	{
		return super.equ(item);
	}*/
	
	public function getFilePathToRunWithEditor() : String return null;
	
	public function getLibraryFilePaths() : Array<String> return [];
}
