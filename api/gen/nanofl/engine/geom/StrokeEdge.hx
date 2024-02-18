package nanofl.engine.geom;

extern class StrokeEdge extends nanofl.engine.geom.Edge implements nanofl.engine.ISelectable {
	function new(x1:Float, y1:Float, x2:Float, y2:Float, ?x3:Float, ?y3:Float, ?stroke:nanofl.engine.strokes.IStroke, ?selected:Bool):Void;
	var stroke : nanofl.engine.strokes.IStroke;
	@:isVar
	var selected(get, set) : Bool;
	private function get_selected():Bool;
	private function set_selected(v:Bool):Bool;
	function getNearestPointUseStrokeSize(x:Float, y:Float):{ var point : nanofl.engine.geom.Point; var t : Float; };
	function addTo(edges:Array<nanofl.engine.geom.StrokeEdge>):Void;
	override function transform(m:nanofl.engine.geom.Matrix, ?applyToStrokeThickness:Bool):Void;
	override function translate(dx:Float, dy:Float):Void;
	override function clone():nanofl.engine.geom.StrokeEdge;
	override function duplicate(e:nanofl.engine.geom.Edge):nanofl.engine.geom.StrokeEdge;
	override function split(tt:Array<Float>):Array<nanofl.engine.geom.Edge>;
	override function toString():String;
	static function fromEdge(edge:nanofl.engine.geom.Edge, ?stroke:nanofl.engine.strokes.IStroke, ?selected:Bool):nanofl.engine.geom.StrokeEdge;
}