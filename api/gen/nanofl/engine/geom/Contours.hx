package nanofl.engine.geom;

extern class Contours {
	static function fromEdges(edges:Array<nanofl.engine.geom.Edge>):Array<nanofl.engine.geom.Contour>;
	static function fromVectors(vectors:Array<nanofl.engine.geom.Edge>):Array<nanofl.engine.geom.Contour>;
	static function mergeByCommonEdges(contours:Array<nanofl.engine.geom.Contour>, counterClockwise:Bool):Void;
	static function removeNested(contours:Array<nanofl.engine.geom.Contour>):Void;
	static function removeTailEdges(edges:Array<nanofl.engine.geom.Edge>):Void;
	static function getEdges(contours:Array<nanofl.engine.geom.Contour>):Array<nanofl.engine.geom.Edge>;
	static function getTree(contours:Array<nanofl.engine.geom.Contour>):Array<nanofl.engine.geom.Tree<nanofl.engine.geom.Contour>>;
}