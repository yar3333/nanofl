package nanofl.ide.library;

extern class LibraryItems {
	static function load(preferences:nanofl.ide.preferences.Preferences, libraryDir:String, relativeFilePaths:Array<String>):js.lib.Promise<Array<nanofl.ide.libraryitems.IIdeLibraryItem>>;
	static function saveToXml(items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>, out:htmlparser.XmlBuilder):Void;
	static function loadFromXml(xml:htmlparser.HtmlNodeElement):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	static function getFiles(items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>):Array<String>;
	static function drag(document:nanofl.ide.Document, item:nanofl.ide.libraryitems.IIdeLibraryItem, items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>, out:htmlparser.XmlBuilder):nanofl.ide.draganddrop.AllowedDropEffect;
	static function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, document:nanofl.ide.Document, folder:String, documentTools:nanofl.ide.DocumentTools):js.lib.Promise<Array<nanofl.ide.libraryitems.IIdeLibraryItem>>;
}