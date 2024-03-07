package nanofl.ide.libraryitems;

import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.elements.Instance;

interface IIdeInstancableItem
    extends IIdeLibraryItem
	extends ISymbol
{
	function newInstance() : Instance;
	
	function getUsedSymbolNamePaths() : Array<String>;
	function getDisplayObjectClassName() : String;
	
	function createDisplayObject() : easeljs.display.DisplayObject;
}