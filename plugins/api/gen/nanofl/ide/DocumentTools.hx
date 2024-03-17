package nanofl.ide;

extern class DocumentTools extends nanofl.ide.InjectContainer {
	function new():Void;
	function loadLibraryAndProperties(path:String, lastModified:Date):js.lib.Promise<{ public var properties(default, default) : nanofl.ide.DocumentProperties; public var library(default, default) : nanofl.ide.library.IdeLibrary; public var lastModified(default, default) : Date; }>;
	function import_(path:String, ?importer:nanofl.ide.plugins.Importer):js.lib.Promise<nanofl.ide.Document>;
	function reload(document:nanofl.ide.Document):js.lib.Promise<{ public var removed(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; public var added(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; }>;
	function reloadWoTransactionForced(document:nanofl.ide.Document):js.lib.Promise<{ public var removed(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; public var added(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; }>;
}