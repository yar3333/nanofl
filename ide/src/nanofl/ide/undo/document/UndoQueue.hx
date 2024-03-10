package nanofl.ide.undo.document;

import datatools.ArrayTools;
import nanofl.engine.elements.Element;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.Document;
import nanofl.ide.library.IdeLibraryTools;
import nanofl.ide.ui.View;
import nanofl.ide.undo.states.*;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class UndoQueue extends undoqueue.UndoQueue<Changes, Operation>
{
	@inject var view : View;
	
	var document : Document;
	
	var oldDocumentState : DocumentState;
	var oldFigureState : FigureState;
	
	var oldTransformationStates : Array<TransformationState>;
	var oldElementsState : ElementsState<Element>;
	var oldTimelineState : TimelineState;
	var oldElementStates = new Array<{ element:Element, state:ElementState }>();
	
	var oldLibraryState_changeItems : LibraryState;
	var oldLibraryState_addItems : LibraryState;
	var oldLibraryState_removeItems : LibraryState;
	var oldLibraryState_renameItems : { state:LibraryState, itemRenames:Array<{ oldNamePath:String, newNamePath:String }> };
	
	@:noapi
	public function new(document:Document)
	{
		super();
		Globals.injector.injectInto(this);
		
		this.document = document;
	}
	
	function rememberStates(changes:Changes)
	{
		if (oldDocumentState == null && changes.document)
		{
			log("\tsave DOCUMENT");
			oldDocumentState = document.properties.clone();
		}
		
		if (oldLibraryState_changeItems == null && changes.libraryChangeItems != null && changes.libraryChangeItems.length > 0)
		{
			log("\tsave LIBRARY(changeItems)");
			oldLibraryState_changeItems = document.library.getState(changes.libraryChangeItems);
		}
		
		if (oldLibraryState_addItems == null && changes.libraryAddItems)
		{
			log("\tsave LIBRARY(addItem)");
			oldLibraryState_addItems = document.library.getState([]);
		}
		
		if (oldLibraryState_removeItems == null && changes.libraryRemoveItems != null && changes.libraryRemoveItems.length > 0)
		{
			log("\tsave LIBRARY(removeItems)");
			var items = document.library.getWithExandedFolders(changes.libraryRemoveItems.map(document.library.getItem));
			oldLibraryState_removeItems = document.library.getState
			(
				IdeLibraryTools.getItemsContainInstances(document.library.getRawLibrary(), items.map(x -> x.namePath))
							.map(x -> x.namePath)
			);
		}
		
		if (oldLibraryState_renameItems == null && changes.libraryRenameItems != null && changes.libraryRenameItems.length > 0)
		{
			log("\tsave LIBRARY(renameItem)");
			oldLibraryState_renameItems =
			{
				state: document.library.getState([]),
				itemRenames: changes.libraryRenameItems
			};
		}
		
		if (changes.figure)
		{
            if (oldFigureState == null)
            {
                log("\tsave FIGURE");
                oldFigureState = document.editor.figure.getState();
            }
		}
		
		if (changes.transformations)
		{
            if (oldTransformationStates == null)
            {
                log("\tsave TRANSFORMATIONS");
                oldTransformationStates = document.editor.getTransformationStates();
            }
		}
		
		if (changes.elements)
		{
            if (oldElementsState == null)
            {
                log("\tsave ELEMENTS");
                oldElementsState = document.editor.getElementsState();
            }
		}
		
		if (changes.timeline)
		{
            Debug.assert(oldTimelineState == null, "Transaction with timeline already started.");
            log("\tsave TIMELINE");
            oldTimelineState = document.navigator.pathItem.mcItem.getTimelineState();
		}
		
		if (changes.element != null && !oldElementStates.exists(e -> e.element == changes.element))
		{
			log("\tsave ELEMENT " + changes.element.toString());
			oldElementStates.push({ element:changes.element, state:changes.element.getState() });
		}
	}
	
	function restoreFromStoredStates()
	{
		if (oldDocumentState != null)
		{
			log("revert document");
			document.setProperties(oldDocumentState);
		}
		
		if (oldLibraryState_changeItems != null)
		{
			log("revert library.changeItems");
			document.library.setState(oldLibraryState_changeItems);
		}
		
		if (oldLibraryState_addItems != null)
		{
			log("revert library.addItem");
			document.library.setState(oldLibraryState_addItems);
		}
		
		if (oldLibraryState_removeItems != null)
		{
			log("revert library.removeItems");
			document.library.setState(oldLibraryState_removeItems);
		}
		
		if (oldLibraryState_renameItems != null)
		{
			log("revert library.renameItems");
			document.library.setState(oldLibraryState_renameItems.state);
		}
		
		if (oldFigureState != null)
		{
			log("revert figure");
			document.editor.figure.setState(oldFigureState);
		}
		
		if (oldTransformationStates != null)
		{
			log("revert transformations");
			document.editor.setTransformationStates(oldTransformationStates);
		}
		
		if (oldElementsState != null)
		{
			log("revert elements");
			document.editor.setElementsState(oldElementsState);
		}
		
		if (oldTimelineState != null)
		{
			log("revert timeline");
			document.navigator.pathItem.mcItem.setTimelineState(oldTimelineState);
		}
		
		if (oldElementStates.length > 0)
		{
			for (oldElementState in oldElementStates)
			{
				log("revert element" + oldElementState.element.toString());
				oldElementState.element.setState(oldElementState.state);
			}
		}
	}
	
	function clearStoredStates()
	{
		oldDocumentState = null;
		oldFigureState = null;
		oldTransformationStates = null;
		oldElementsState = null;
		oldTimelineState = null;
		oldElementStates = [];
		oldLibraryState_changeItems = null;
		oldLibraryState_addItems = null;
		oldLibraryState_removeItems = null;
		oldLibraryState_renameItems = null;
	}
	
	function addOperationsFromStoredStates()
	{
		if (oldDocumentState != null)
		{
			if (!document.properties.equ(oldDocumentState))
			{
				addOperation(Operation.DOCUMENT(oldDocumentState, document.properties));
			}
		}
		
		if (oldLibraryState_changeItems != null)
		{
			if (!ArrayTools.equ(document.library.getItems(true), oldLibraryState_changeItems))
			{
				addOperation(Operation.LIBRARY_CHANGE_ITEMS(oldLibraryState_changeItems, document.library.getState(oldLibraryState_changeItems.map(x -> x.namePath))));
			}
		}
		
		if (oldLibraryState_addItems != null)
		{
			addOperation(Operation.LIBRARY_ADD_ITEMS(oldLibraryState_addItems, document.library.getState([])));
		}
		
		if (oldLibraryState_removeItems != null)
		{
			addOperation(Operation.LIBRARY_REMOVE_ITEMS(oldLibraryState_removeItems, document.library.getState([])));
		}
		
		if (oldLibraryState_renameItems != null)
		{
			addOperation(Operation.LIBRARY_RENAME_ITEMS(oldLibraryState_renameItems.state, document.library.getState([]), oldLibraryState_renameItems.itemRenames));
		}
		
		if (oldFigureState != null)
		{
			var newFigureState = document.editor.figure.getState();
			if (!oldFigureState.equ(newFigureState))
			{
				addOperation(Operation.FIGURE(document.navigator.getState(), oldFigureState, newFigureState));
			}
		}
		
		if (oldTransformationStates != null)
		{
			var newTransformationStates = document.editor.getTransformationStates();
			if (!ArrayTools.equ(oldTransformationStates, newTransformationStates))
			{
				addOperation(Operation.TRANSFORMATIONS(document.navigator.getState(), oldTransformationStates, newTransformationStates));
			}
		}
		
		if (oldElementsState != null)
		{
			var newElementsState = document.editor.getElementsState();
			addOperation(Operation.ELEMENTS(document.navigator.getState(), oldElementsState, newElementsState));
		}
		
		if (oldTimelineState != null)
		{
			var newTimelineState = document.navigator.pathItem.mcItem.getTimelineState();
			addOperation(Operation.TIMELINE(document.navigator.getState(), oldTimelineState, newTimelineState));
		}
		
		for (oldElementState in oldElementStates)
		{
			var elementIndex = document.editor.activeLayer.getElementIndex(oldElementState.element);
			Debug.assert(elementIndex >= 0, "Wrong elementIndex = " + elementIndex);
			var newElementState = oldElementState.element.getState();
			if (!oldElementState.state.equ(newElementState))
			{
				addOperation(Operation.ELEMENT(document.navigator.getState(), elementIndex, oldElementState.state, newElementState));
			}
		}
	}
	
	function newTransaction() : Transaction
	{
		return new Transaction(document, view);
	}
	
	override function changed() 
	{
		document.undoStatusChanged();
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
