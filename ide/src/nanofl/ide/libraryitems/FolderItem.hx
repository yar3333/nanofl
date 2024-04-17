package nanofl.ide.libraryitems;

import htmlparser.HtmlNodeElement;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.MediaUtils;

class FolderItem extends nanofl.engine.libraryitems.FolderItem
	implements IIdeLibraryItem
{
	override public function clone() : FolderItem
	{
		var obj  = new FolderItem(namePath);
		obj.opened = opened;
		copyBaseProperties(obj);
		return obj;
	}
	
	override public function save(fileSystem:FileSystem) 
	{
		if (hasDataToSave()) fileSystem.createDirectory(library.libraryDir + "/" + namePath);
	}
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : FolderItem
	{
		if (itemNode.name != "folder") return null;
		
		return new FolderItem(namePath);
	}
	
	public function getLibraryFilePaths() 
	{
		return [ namePath ];
	}

    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:FileSystem, destLibraryDir:String) : Dynamic
    {
        return null;
    }
        
	public function publish(fileSystem:FileSystem, mediaUtils:MediaUtils, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
	{
		return null;
	}
}