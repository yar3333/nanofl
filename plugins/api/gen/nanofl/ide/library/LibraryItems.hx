package nanofl.ide.library;

extern class LibraryItems {
	static function load(preferences:nanofl.ide.preferences.Preferences, libraryDir:String, relativeFilePaths:Array<String>):js.lib.Promise<Array<nanofl.ide.libraryitems.IIdeLibraryItem>>;
	static function saveToXml(items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>, out:htmlparser.XmlBuilder):Void;
	static function loadFromXml(xml:htmlparser.HtmlNodeElement):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	static function getFiles(items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>):Array<String>;
}