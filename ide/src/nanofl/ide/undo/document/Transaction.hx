package nanofl.ide.undo.document;

import nanofl.ide.Document;
import nanofl.ide.ui.View;
using stdlib.Lambda;

class Transaction extends undoqueue.Transaction<Operation>
{
	var document : Document;
	var view : View;
	
	public function new(document:Document, view:View, ?operations:Array<Operation>)
	{
		super(operations);
		
		this.document = document;
		this.view = view;
	}
	
	function applyOperation(operation:Operation)
	{
		log("\t" + operation.getName());
		
		switch (operation)
		{
			case Operation.DOCUMENT(oldDocumentState, newDocumentState):
				document.setProperties(newDocumentState);
				
			case Operation.FIGURE(navigatorState, oldFigureState, newFigureState):
				document.navigator.setState(navigatorState);
				document.editor.figure.setState(newFigureState);
				
			case Operation.ELEMENT(navigatorState, elementIndex, oldElementState, newElementState):
				document.navigator.setState(navigatorState);
				document.editor.activeLayer.getElementByIndex(elementIndex).setState(newElementState);
				
			case Operation.TRANSFORMATIONS(navigatorState, oldTransformationStates, newTransformationStates):
				document.navigator.setState(navigatorState);
				document.editor.setTransformationStates(newTransformationStates);
				
			case Operation.ELEMENTS(navigatorState, oldElementsState, newElementsState):
				document.navigator.setState(navigatorState);
                log(() -> "newElementsState =\n" + newElementsState);
				document.editor.setElementsState(newElementsState);
				
			case Operation.TIMELINE(navigatorState, oldTimelineState, newTimelineState):
				document.navigator.setState(navigatorState);
				document.navigator.pathItem.mcItem.setTimelineState(newTimelineState);
				view.movie.timeline.update();
				
			case Operation.LIBRARY_ADD_ITEMS(oldLibraryState, newLibraryState):
				document.library.setState(newLibraryState);
				document.library.update();
				
			case Operation.LIBRARY_REMOVE_ITEMS(oldLibraryState, newLibraryState):
				document.library.setState(newLibraryState);
				document.library.update();
				
			case Operation.LIBRARY_RENAME_ITEMS(oldLibraryState, newLibraryState, itemRenames):
				document.library.setState(newLibraryState);
				document.library.renameItems(itemRenames);
				
			case Operation.LIBRARY_CHANGE_ITEMS(oldLibraryState, newLibraryState):
				document.library.setState(newLibraryState);
				document.library.update();
		}
		
		document.editor.rebind();
	}
	
	function getReversedOperation(operation:Operation) : Operation
	{
		switch (operation)
		{
			case Operation.DOCUMENT(oldDocumentState, newDocumentState):
				return Operation.DOCUMENT(newDocumentState, oldDocumentState);
				
			case Operation.FIGURE(navigatorState, oldFigureState, newFigureState):
				return Operation.FIGURE(navigatorState, newFigureState, oldFigureState);
				
			case Operation.ELEMENT(navigatorState, elementIndex, oldElementState, newElementState):
				return Operation.ELEMENT(navigatorState, elementIndex, newElementState, oldElementState);
				
			case Operation.TRANSFORMATIONS(navigatorState, oldTransformationStates, newTransformationStates):
				return Operation.TRANSFORMATIONS(navigatorState, newTransformationStates, oldTransformationStates);
				
			case Operation.ELEMENTS(navigatorState, oldElementsState, newElementsState):
				return Operation.ELEMENTS(navigatorState, newElementsState, oldElementsState);
				
			case Operation.TIMELINE(navigatorState, oldTimelineState, newTimelineState):
				return Operation.TIMELINE(navigatorState, newTimelineState, oldTimelineState);
				
			case Operation.LIBRARY_ADD_ITEMS(oldLibraryState, newLibraryState):
				return Operation.LIBRARY_REMOVE_ITEMS(newLibraryState, oldLibraryState);
				
			case Operation.LIBRARY_REMOVE_ITEMS(oldLibraryState, newLibraryState):
				return Operation.LIBRARY_ADD_ITEMS(newLibraryState, oldLibraryState);
				
			case Operation.LIBRARY_RENAME_ITEMS(oldLibraryState, newLibraryState, itemRenames):
				return Operation.LIBRARY_RENAME_ITEMS(newLibraryState, oldLibraryState, itemRenames.map(x -> { oldNamePath:x.newNamePath, newNamePath:x.oldNamePath }));
				
			case Operation.LIBRARY_CHANGE_ITEMS(oldLibraryState, newLibraryState):
				return Operation.LIBRARY_CHANGE_ITEMS(newLibraryState, oldLibraryState);
		}
	}
	
	function newTransaction(operations:Array<Operation>)
	{
		return new Transaction(document, view, operations);
	}
	
	static function log(v:Dynamic)
	{
		nanofl.engine.Log.console.namedLog("Transaction", v);
	}
}