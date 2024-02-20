package nanofl.engine;

interface IPathElement extends nanofl.engine.ILayersContainer {
	var visible : Bool;
	var matrix : nanofl.engine.geom.Matrix;
	function isScene():Bool;
	function getNavigatorName():String;
	function getNavigatorIcon():String;
	function getChildren():datatools.ArrayRO<nanofl.engine.elements.Element>;
	function createDisplayObject(frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	function getTimeline():nanofl.engine.ITimeline;
}