package nanofl.ide.libraryitems;

import htmlparser.XmlBuilder;

interface IIdeLibraryItem extends nanofl.engine.ILibraryItem
{
	function save(fileSystem:nanofl.ide.sys.FileSystem) : Void;
	
	function saveToXml(out:XmlBuilder) : Void;
	
    function saveToJson() : Dynamic;
	
	function getFilePathToRunWithEditor() : String;
	
	function getLibraryFilePaths() : Array<String>;
	
    function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String) : Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem;
}