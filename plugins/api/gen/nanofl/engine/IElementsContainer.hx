package nanofl.engine;

interface IElementsContainer {
	var elements(get, never) : datatools.ArrayRO<nanofl.engine.elements.Element>;
	function addElement(element:nanofl.engine.elements.Element, ?index:Int):Void;
	function removeElementAt(n:Int):Void;
	function removeElement(element:nanofl.engine.elements.Element):Void;
	function toString():String;
}