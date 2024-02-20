package nanofl.ide.libraryitems;

interface IIdeInstancableItem extends nanofl.ide.ISymbol extends nanofl.ide.libraryitems.IIdeLibraryItem {
	function newInstance():nanofl.engine.elements.Instance;
	function getUsedSymbolNamePaths():Array<String>;
	function getDisplayObjectClassName():String;
	function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
}