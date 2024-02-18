package nanofl.ide.libraryitems;

import htmlparser.HtmlNodeElement;
import nanofl.ide.libraryitems.IIdeLibraryItem;
using stdlib.StringTools;
using stdlib.Lambda;

class FontItem extends nanofl.engine.libraryitems.FontItem
	implements IIdeLibraryItem
{
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : FontItem
	{
		if (itemNode.name != "font") return null;
		
        var r = new FontItem(namePath, []);
        r.loadProperties(itemNode);
		return r;
	}
	
	override public function clone() : FontItem
	{
		var obj = new FontItem(namePath, variants.copy());
		copyBaseProperties(obj);
		return obj;
	}
	
	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String) : IIdeLibraryItem
	{
		var files = [];
		for (variant in variants)
		{
			files = files.concat(variant.urls.filter(x -> x.indexOf("//") < 0).array());
		}
		fileSystem.copyLibraryFiles(library.libraryDir, files, destLibraryDir);
		return clone();
	}
	
	public function getFilePathToRunWithEditor() : String return null;
	
	public function getLibraryFilePaths() : Array<String> return [];
}