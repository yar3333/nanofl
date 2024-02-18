package nanofl.engine;

import easeljs.display.DisplayObject;
import nanofl.engine.geom.Matrix;
import datatools.ArrayRO;
import nanofl.engine.elements.Element;

interface IPathElement extends ILayersContainer
{
	var visible : Bool;
	var matrix : Matrix;
	
	function isScene() : Bool;
	function getNavigatorName() : String;
	function getNavigatorIcon() : String;
	function getChildren() : ArrayRO<Element>;
	function createDisplayObject(frameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : DisplayObject;
	
	function getTimeline() : ITimeline;
}
