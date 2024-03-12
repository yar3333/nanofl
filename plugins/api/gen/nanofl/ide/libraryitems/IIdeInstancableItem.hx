package nanofl.ide.libraryitems;

interface IIdeInstancableItem extends nanofl.ide.ISymbol extends nanofl.ide.libraryitems.IIdeLibraryItem {
	function newInstance():nanofl.engine.elements.Instance;
	function getUsedSymbolNamePaths():js.lib.Set<String>;
	function getDisplayObjectClassName():String;
	function createDisplayObject(params:Dynamic):easeljs.display.DisplayObject;
}