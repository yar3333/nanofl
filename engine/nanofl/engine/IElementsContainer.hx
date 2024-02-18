package nanofl.engine;

import datatools.ArrayRO;
import nanofl.engine.elements.Element;

interface IElementsContainer
{
	var elements(get, never) : ArrayRO<Element>;
	
	function addElement(element:Element, ?index:Int) : Void;
	function removeElementAt(n:Int) : Void;
	function removeElement(element:Element) : Void;
	function toString() : String;
}