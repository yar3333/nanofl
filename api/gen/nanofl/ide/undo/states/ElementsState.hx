package nanofl.ide.undo.states;

extern class ElementsState<Element> {
	function new(layerElements:Array<{ public var elements(default, default) : Array<Element>; }>):Void;
	var layerElements(default, null) : Array<{ public var elements(default, default) : Array<Element>; }>;
}