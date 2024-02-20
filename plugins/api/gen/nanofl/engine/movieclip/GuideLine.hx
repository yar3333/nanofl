package nanofl.engine.movieclip;

extern class GuideLine {
	function new(?shape:nanofl.engine.elements.ShapeElement):Void;
	/**
		
		        Assume return array is not empty.
		    
	**/
	function getPath(startPos:nanofl.engine.geom.Point, finishPos:nanofl.engine.geom.Point):Array<nanofl.engine.geom.Edge>;
}