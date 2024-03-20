package nanofl.ide.libraryitems;

interface IIdeLibraryItem extends nanofl.engine.ILibraryItem {
	function save(fileSystem:nanofl.ide.sys.FileSystem):Void;
	function saveToXml(out:htmlparser.XmlBuilder):Void;
	function saveToJson():Dynamic;
	function getLibraryFilePaths():Array<String>;
	function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String):Dynamic;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, mediaUtils:nanofl.ide.sys.MediaUtils, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic):nanofl.ide.libraryitems.IIdeLibraryItem;
}