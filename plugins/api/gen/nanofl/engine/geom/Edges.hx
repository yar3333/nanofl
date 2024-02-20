package nanofl.engine.geom;

extern class Edges {
	static var showSelection : Bool;
	static function hasDuplicates<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Bool;
	static function removeDublicates<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Void;
	static function concatUnique<T:(nanofl.engine.geom.Edge), Z:(T)>(edgesA:Array<T>, edgesB:Array<Z>):Array<T>;
	static function appendUnique<T:(nanofl.engine.geom.Edge), Z:(T)>(edgesA:Array<T>, edgesB:Array<Z>):Array<T>;
	static function exclude(edges:Array<nanofl.engine.geom.Edge>, exclude:Array<nanofl.engine.geom.Edge>):Array<nanofl.engine.geom.Edge>;
	static function draw<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, g:nanofl.engine.ShapeRender, fixLineJoinsInClosedContours:Bool):Void;
	static function getBounds<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, ?bounds:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	static function export<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, out:htmlparser.XmlBuilder):Void;
	static function exportStroked(edges:Array<nanofl.engine.geom.StrokeEdge>, out:htmlparser.XmlBuilder):Void;
	static function load(s:String):Array<nanofl.engine.geom.Edge>;
	static function save(edges:Array<nanofl.engine.geom.Edge>):String;
	static function replace<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, search:nanofl.engine.geom.Edge, replacement:Array<nanofl.engine.geom.Edge>):Int;
	static function replaceAll<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, search:nanofl.engine.geom.Edge, replacement:Array<nanofl.engine.geom.Edge>):Void;
	static function replaceAt<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, n:Int, replacement:Array<nanofl.engine.geom.Edge>, reverse:Bool):Void;
	static function intersect<T:(nanofl.engine.geom.Edge)>(edgesA:Array<T>, edgesB:Array<T>, ?onReplace:(nanofl.engine.geom.Edge, Array<nanofl.engine.geom.Edge>) -> Void):Void;
	static function intersectSelf<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, ?onReplace:(nanofl.engine.geom.Edge, Array<nanofl.engine.geom.Edge>) -> Void):Void;
	static function normalize<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Array<T>;
	static function roundPoints<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Array<T>;
	static function removeDegenerated<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, ?removeAlsoCurvesWithStartAndEndEquals:Bool):Array<T>;
	static function isPointInside(edges:Array<nanofl.engine.geom.Edge>, x:Float, y:Float, fillEvenOdd:Bool):Bool;
	static function isSequence<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Bool;
	static function hasDegenerated<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Bool;
	static function getPointUseCount<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, x:Float, y:Float):Int;
	static function equIgnoreOrder(edgesA:Array<nanofl.engine.geom.Edge>, edgesB:Array<nanofl.engine.geom.Edge>):Bool;
	static function getCommon(edgesA:Array<nanofl.engine.geom.Edge>, edgesB:Array<nanofl.engine.geom.Edge>):Array<nanofl.engine.geom.Edge>;
	static function getDifferent(edgesA:Array<nanofl.engine.geom.Edge>, edgesB:Array<nanofl.engine.geom.Edge>):Array<nanofl.engine.geom.Edge>;
	static function getNearestVertex(edges:Array<nanofl.engine.geom.Edge>, x:Float, y:Float):nanofl.engine.geom.Point;
	static function getTailPoints(edges:Array<nanofl.engine.geom.Edge>):Array<nanofl.engine.geom.Point>;
	static function smoothStraightLineSequence<T:(nanofl.engine.geom.Edge)>(edges:Array<T>, power:Float):Void;
	static function assertHasNoIntersections<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Void;
	static function simplificate<T:(nanofl.engine.geom.Edge)>(sequence:Array<T>, eps:Float):Array<T>;
}