package nanofl.ide.library;

extern class IdeLibraryTools {
	static function optimize(library:nanofl.ide.library.IdeLibrary):Void;
	static function getUsedItems(library:nanofl.ide.library.IdeLibrary, useTextureAtlases:Bool):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	static function getUnusedItems(library:nanofl.ide.library.IdeLibrary, useTextureAtlases:Bool):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	static function getItemsContainInstances(library:nanofl.ide.library.IdeLibrary, namePaths:Array<String>):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	static function hasEquItems(library:nanofl.ide.library.IdeLibrary, items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>):Bool;
}