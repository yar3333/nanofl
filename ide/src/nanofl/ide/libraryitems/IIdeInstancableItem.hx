package nanofl.ide.libraryitems;

import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.elements.Instance;
import nanofl.engine.IPathElement;

interface IIdeInstancableItem
    extends IIdeLibraryItem
	extends ISymbol
{
	function newInstance() : Instance;
	
	function getUsedSymbolNamePaths() : Array<String>;
	function getDisplayObjectClassName() : String;
	
	function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject;
}