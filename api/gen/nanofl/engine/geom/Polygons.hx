package nanofl.engine.geom;

extern class Polygons {
	static function findByPoint(polygons:Array<nanofl.engine.geom.Polygon>, x:Float, y:Float):nanofl.engine.geom.Polygon;
	static function isEdgeInside(polygons:Array<nanofl.engine.geom.Polygon>, edge:nanofl.engine.geom.Edge):Bool;
	static function mergeByCommonEdges(polygons:Array<nanofl.engine.geom.Polygon>, edges:Array<nanofl.engine.geom.StrokeEdge>):Void;
	static function removeDublicates(polygons:Array<nanofl.engine.geom.Polygon>):Void;
	static function normalize(polygons:Array<nanofl.engine.geom.Polygon>):Void;
	static function getEdges(polygons:Array<nanofl.engine.geom.Polygon>):Array<nanofl.engine.geom.Edge>;
	static function getByPoint(polygons:Array<nanofl.engine.geom.Polygon>, pos:nanofl.engine.geom.Point):nanofl.engine.geom.Polygon;
	static function fromEdges(edges:Array<nanofl.engine.geom.Edge>, strokeEdges:Array<nanofl.engine.geom.StrokeEdge>, polygonsToDetectFill:Array<nanofl.engine.geom.Polygon>):Array<nanofl.engine.geom.Polygon>;
	static function fromRawContours(originalContours:Array<nanofl.engine.geom.Contour>, fill:nanofl.engine.fills.IFill, fillEvenOdd:Bool):Array<nanofl.engine.geom.Polygon>;
	static function assertCorrect(polygons:Array<nanofl.engine.geom.Polygon>, intergrityChecks:Bool, ?message:Dynamic):Void;
	static function removeErased(polygons:Array<nanofl.engine.geom.Polygon>):Void;
	/**
		
			 * Compare with fill testing.
			 
	**/
	static function equ(a:Array<nanofl.engine.geom.Polygon>, b:Array<nanofl.engine.geom.Polygon>):Bool;
}