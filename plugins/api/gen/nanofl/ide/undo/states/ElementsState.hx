package nanofl.ide.undo.states;

extern class ElementsState {
	function new(layerElements:Array<{ public var elements(default, default) : Array<nanofl.engine.elements.Element>; }>):Void;
	var layerElements(default, null) : Array<{ public var elements(default, default) : Array<nanofl.engine.elements.Element>; }>;
	function toString():String;
}