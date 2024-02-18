package nanofl.ide.undo.document;

import nanofl.engine.elements.Element;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.undo.states.DocumentState;
import nanofl.ide.undo.states.ElementState;
import nanofl.ide.undo.states.ElementsState;
import nanofl.ide.undo.states.FigureState;
import nanofl.ide.undo.states.LibraryState;
import nanofl.ide.undo.states.NavigatorState;
import nanofl.ide.undo.states.TimelineState;
import nanofl.ide.undo.states.TransformationState;

enum Operation
{
	DOCUMENT(oldDocumentState:DocumentState, newDocumentState:DocumentState);
	
	LIBRARY_ADD_ITEMS(oldLibraryState:LibraryState, newLibraryState:LibraryState);
	LIBRARY_REMOVE_ITEMS(oldLibraryState:LibraryState, newLibraryState:LibraryState);
	LIBRARY_RENAME_ITEMS(oldLibraryState:LibraryState, newLibraryState:LibraryState, itemRenames:Array<{ oldNamePath:String, newNamePath:String }>);
	LIBRARY_CHANGE_ITEMS(oldLibraryState:LibraryState, newLibraryState:LibraryState);
	
	TIMELINE(navigatorState:NavigatorState, oldTimelineState:TimelineState, newTimelineState:TimelineState);
	ELEMENTS(navigatorState:NavigatorState, oldElementsState:ElementsState<Element>, newElementsState:ElementsState<Element>);
	ELEMENT(navigatorState:NavigatorState, elementIndex:Int, oldElementState:ElementState, newElementState:ElementState);
	FIGURE(navigatorState:NavigatorState, oldFigureState:FigureState, newFigureState:FigureState);
	TRANSFORMATIONS(navigatorState:NavigatorState, oldTransformationStates:Array<TransformationState>, newTransformationStates:Array<TransformationState>);
}
