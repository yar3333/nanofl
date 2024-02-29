package nanofl.engine.elements;

extern class ShapeElement extends nanofl.engine.elements.Element {
	function new(?edges:Array<nanofl.engine.geom.StrokeEdge>, ?polygons:Array<nanofl.engine.geom.Polygon>, ?isNormalize:Bool):Void;
	var edges(default, null) : Array<nanofl.engine.geom.StrokeEdge>;
	var polygons(default, null) : Array<nanofl.engine.geom.Polygon>;
	override function saveProperties(out:htmlparser.XmlBuilder):Void;
	function ensureNoTransform():Void;
	function draw(g:nanofl.engine.ShapeRender, scaleSelection:Float):Void;
	override function createDisplayObject(frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.Shape;
	override function clone():nanofl.engine.elements.ShapeElement;
	override function translate(dx:Float, dy:Float):Void;
	function isEmpty():Bool;
	function hasSelected():Bool;
	function isAllSelected():Bool;
	function hasSelectedEdges():Bool;
	function hasSelectedPolygons():Bool;
	function select(obj:{ var selected : Bool; }):Void;
	function selectAll():Void;
	function deselectAll():Void;
	function translateSelected(dx:Float, dy:Float):Void;
	function translateVertex(point:nanofl.engine.geom.Point, dx:Float, dy:Float):Void;
	function removeSelected():Void;
	function getPolygonAtPos(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Polygon;
	function getSameEdges(edge:nanofl.engine.geom.Edge):Array<nanofl.engine.geom.Edge>;
	function getNearestStrokeEdge(pt:nanofl.engine.geom.Point):{ var dist : Float; var edge : nanofl.engine.geom.StrokeEdge; var point : nanofl.engine.geom.Point; var t : Float; };
	function getNearestPolygonEdge(pt:nanofl.engine.geom.Point):{ var dist : Float; var edge : nanofl.engine.geom.Edge; var point : nanofl.engine.geom.Point; var t : Float; };
	function getNearestVertex(pt:nanofl.engine.geom.Point, ?excludeSelf:Bool):{ var dist : Float; var distMinusEdgeThickness : Float; var point : nanofl.engine.geom.Point; };
	function setSelectedEdgesStroke(stroke:nanofl.engine.strokes.IStroke):Void;
	function setSelectedEdgesStrokeParams(params:nanofl.engine.strokes.StrokeParams):Void;
	function getSelectedEdgesStrokeParams():{ @:optional
	var bitmapPath : String; @:optional
	var caps : String; @:optional
	var color : String; @:optional
	var colors : Array<String>; @:optional
	var ignoreScale : Bool; @:optional
	var joints : String; @:optional
	var miterLimit : Float; @:optional
	var r : Float; @:optional
	var ratios : Array<Float>; @:optional
	var thickness : Float; var type : String; @:optional
	var x0 : Float; @:optional
	var x1 : Float; @:optional
	var y0 : Float; @:optional
	var y1 : Float; };
	function setSelectedPolygonsFill(fill:nanofl.engine.fills.IFill, ?x1:Float, ?y1:Float, ?x2:Float, ?y2:Float):Void;
	function setSelectedPolygonsFillParams(params:nanofl.engine.fills.FillParams):Void;
	function getSelectedPolygonsFillParams():{ @:optional
	var bitmapPath : String; @:optional
	var color : String; @:optional
	var colors : Array<String>; @:optional
	var matrix : nanofl.engine.geom.Matrix; @:optional
	var r : Float; @:optional
	var ratios : Array<Float>; @:optional
	var repeat : String; var type : String; @:optional
	var x0 : Float; @:optional
	var x1 : Float; @:optional
	var y0 : Float; @:optional
	var y1 : Float; };
	function floodFill(fill:nanofl.engine.fills.IFill, x1:Float, y1:Float, x2:Float, y2:Float):Void;
	function getBounds(?bounds:nanofl.engine.geom.Bounds, ?useStrokeThickness:Bool):nanofl.engine.geom.Bounds;
	function getSelectedBounds(?bounds:nanofl.engine.geom.Bounds, ?useStrokeThickness:Bool):nanofl.engine.geom.Bounds;
	override function transform(m:nanofl.engine.geom.Matrix, ?applyToStrokeAndFill:Bool):Void;
	function transformSelected(m:nanofl.engine.geom.Matrix, ?applyToStrokeThickness:Bool):Void;
	function combine(shape:nanofl.engine.elements.ShapeElement):Void;
	function combineSelf():Bool;
	function combineSelected():Void;
	function extractSelected():nanofl.engine.elements.ShapeElement;
	override function getState():nanofl.ide.undo.states.ElementState;
	override function setState(_state:nanofl.ide.undo.states.ElementState):Void;
	function replaceEdge(search:nanofl.engine.geom.Edge, replacement:Array<nanofl.engine.geom.Edge>):Void;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	function applyStrokeAlpha(alpha:Float):Void;
	function applyFillAlpha(alpha:Float):Void;
	function getEdgeCount():Int;
	override function setLibrary(library:nanofl.engine.Library):Void;
	override function equ(element:nanofl.engine.elements.Element):Bool;
	override function fixErrors():Bool;
	override function getUsedSymbolNamePaths():Array<String>;
	override function toString():String;
	static function createRectangle(x:Float, y:Float, width:Float, height:Float, rTopLeft:Float, rTopRight:Float, rBottomRight:Float, rBottomLeft:Float, stroke:nanofl.engine.strokes.IStroke, fill:nanofl.engine.fills.IFill):nanofl.engine.elements.ShapeElement;
	static function createOval(cx:Float, cy:Float, rx:Float, ry:Float, startAngle:Float, endAngle:Float, innerRadius:Float, closePath:Bool, stroke:nanofl.engine.strokes.IStroke, fill:nanofl.engine.fills.IFill):nanofl.engine.elements.ShapeElement;
}