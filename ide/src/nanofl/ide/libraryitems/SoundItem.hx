package nanofl.ide.libraryitems;

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
		var generateAudioExtensions = [];
		if (settings.isGenerateMp3Sounds) generateAudioExtensions.push("mp3");
		if (settings.isGenerateOggSounds) generateAudioExtensions.push("ogg");
		if (settings.isGenerateWavSounds) generateAudioExtensions.push("wav");
		
		for (destExt in generateAudioExtensions)
		{
			var srcFile = library.libraryDir + "/" + namePath + "." + ext;
			var destFile = destLibraryDir + "/" + namePath + "." + destExt;
			new nanofl.ide.MediaConvertor().convertAudio(srcFile, destFile, settings.audioQuality);
		}
		
		return clone();
	}
	
	/*override public function equ(item:ILibraryItem) : Bool
	{
		return super.equ(item);
	}*/
	
	public function getFilePathToRunWithEditor() : String return null;
	
	public function getLibraryFilePaths() : Array<String> return [];
}
