package nanofl.ide.undo.document;

extern enum Operation {
	DOCUMENT(oldDocumentState:nanofl.ide.undo.states.DocumentState, newDocumentState:nanofl.ide.undo.states.DocumentState);
	LIBRARY_ADD_ITEMS(oldLibraryState:nanofl.ide.undo.states.LibraryState, newLibraryState:nanofl.ide.undo.states.LibraryState);
	LIBRARY_REMOVE_ITEMS(oldLibraryState:nanofl.ide.undo.states.LibraryState, newLibraryState:nanofl.ide.undo.states.LibraryState);
	LIBRARY_RENAME_ITEMS(oldLibraryState:nanofl.ide.undo.states.LibraryState, newLibraryState:nanofl.ide.undo.states.LibraryState, itemRenames:Array<{ public var oldNamePath(default, default) : String; public var newNamePath(default, default) : String; }>);
	LIBRARY_CHANGE_ITEMS(oldLibraryState:nanofl.ide.undo.states.LibraryState, newLibraryState:nanofl.ide.undo.states.LibraryState);
	TIMELINE(navigatorState:nanofl.ide.undo.states.NavigatorState, oldTimelineState:nanofl.ide.undo.states.TimelineState, newTimelineState:nanofl.ide.undo.states.TimelineState);
	ELEMENTS(navigatorState:nanofl.ide.undo.states.NavigatorState, oldElementsState:nanofl.ide.undo.states.ElementsState<nanofl.engine.elements.Element>, newElementsState:nanofl.ide.undo.states.ElementsState<nanofl.engine.elements.Element>);
	ELEMENT(navigatorState:nanofl.ide.undo.states.NavigatorState, elementIndex:Int, oldElementState:nanofl.ide.undo.states.ElementState, newElementState:nanofl.ide.undo.states.ElementState);
	FIGURE(navigatorState:nanofl.ide.undo.states.NavigatorState, oldFigureState:nanofl.ide.undo.states.FigureState, newFigureState:nanofl.ide.undo.states.FigureState);
	TRANSFORMATIONS(navigatorState:nanofl.ide.undo.states.NavigatorState, oldTransformationStates:Array<nanofl.ide.undo.states.TransformationState>, newTransformationStates:Array<nanofl.ide.undo.states.TransformationState>);
}