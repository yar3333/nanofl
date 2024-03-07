package nanofl.engine;

import datatools.ArrayRO;
import easeljs.display.DisplayObject;
import nanofl.engine.geom.Matrix;
import nanofl.engine.elements.Element;

interface IPathElement extends ILayersContainer
{
	var visible : Bool;
	var matrix : Matrix;
	
	function isScene() : Bool;
	function getNavigatorName() : String;
	function getNavigatorIcon() : String;
	function getChildren() : ArrayRO<Element>;
	function createDisplayObject() : DisplayObject;
	
	function getTimeline() : ITimeline;
}
