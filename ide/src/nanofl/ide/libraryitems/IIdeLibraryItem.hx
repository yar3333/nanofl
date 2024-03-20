package nanofl.ide.libraryitems;

import htmlparser.XmlBuilder;
import nanofl.ide.sys.FileSystem;

interface IIdeLibraryItem extends nanofl.engine.ILibraryItem
{
	function save(fileSystem:nanofl.ide.sys.FileSystem) : Void;
	
	function saveToXml(out:XmlBuilder) : Void;
	
    function saveToJson() : Dynamic;
	
	function getLibraryFilePaths() : Array<String>;
	
    function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:FileSystem, destLibraryDir:String) : Dynamic;
	function publish(fileSystem:FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem;
}