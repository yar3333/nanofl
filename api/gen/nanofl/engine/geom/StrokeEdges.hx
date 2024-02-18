package nanofl.engine.geom;

extern class StrokeEdges {
	static function load(nodes:Array<htmlparser.HtmlNodeElement>, strokes:Array<nanofl.engine.strokes.IStroke>, version:String):Array<nanofl.engine.geom.StrokeEdge>;
	static function loadJson(objs:Array<Dynamic>, strokes:Array<nanofl.engine.strokes.IStroke>, version:String):Array<nanofl.engine.geom.StrokeEdge>;
	static function save(edges:Array<nanofl.engine.geom.StrokeEdge>, strokes:Array<nanofl.engine.strokes.IStroke>, out:htmlparser.XmlBuilder):Void;
	static function saveJson(edges:Array<nanofl.engine.geom.StrokeEdge>, strokes:Array<nanofl.engine.strokes.IStroke>):Array<Dynamic>;
	static function getBounds(edges:Array<nanofl.engine.geom.StrokeEdge>, ?bounds:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	static function duplicateStrokes(edges:Array<nanofl.engine.geom.StrokeEdge>):Array<nanofl.engine.strokes.IStroke>;
	static function drawSorted(edges:Array<nanofl.engine.geom.StrokeEdge>, g:nanofl.engine.ShapeRender, scaleSelection:Float):Void;
	static function fromEdges(edges:Array<nanofl.engine.geom.Edge>, stroke:nanofl.engine.strokes.IStroke, ?selected:Bool):Array<nanofl.engine.geom.StrokeEdge>;
	static function replace(edges:Array<nanofl.engine.geom.StrokeEdge>, search:nanofl.engine.geom.Edge, replacement:Array<nanofl.engine.geom.Edge>):Void;
	/**
		
			 * Compare with stroke testing.
			 
	**/
	static function equ(a:Array<nanofl.engine.geom.StrokeEdge>, b:Array<nanofl.engine.geom.StrokeEdge>):Bool;
}