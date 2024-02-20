package nanofl.ide.libraryitems;

interface IIdeLibraryItem extends nanofl.engine.ILibraryItem {
	function save(fileSystem:nanofl.ide.sys.FileSystem):Void;
	function saveToXml(out:htmlparser.XmlBuilder):Void;
	function saveToJson():Dynamic;
	function getFilePathToRunWithEditor():String;
	function getLibraryFilePaths():Array<String>;
	function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String):nanofl.ide.libraryitems.IIdeLibraryItem;
}