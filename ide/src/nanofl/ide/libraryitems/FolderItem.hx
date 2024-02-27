package nanofl.ide.libraryitems;

import nanofl.ide.libraryitems.IIdeLibraryItem;
import htmlparser.HtmlNodeElement;

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
	
	override public function save(fileSystem:nanofl.ide.sys.FileSystem) 
	{
		fileSystem.createDirectory(library.libraryDir + "/" + namePath);
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

    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String) : Dynamic
    {
        return null;
    }
        
	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
	{
		return null;
	}
	
	public function getFilePathToRunWithEditor() : String return null;
}