package nanofl.ide.libraryitems;

import js.lib.Set;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.elements.Instance;

interface IIdeInstancableItem
    extends IIdeLibraryItem
	extends ISymbol
{
	function newInstance() : Instance;
	
	function getUsedSymbolNamePaths() : Set<String>;
	function getDisplayObjectClassName() : String;
	
	function createDisplayObject() : easeljs.display.DisplayObject;
}