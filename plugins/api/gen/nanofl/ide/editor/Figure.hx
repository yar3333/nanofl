package nanofl.ide.editor;

extern class Figure {
	function new(editor:nanofl.ide.editor.Editor, layers:Array<nanofl.ide.editor.EditorLayer>):Void;
	function getSameEdgeWithLayers(edge:nanofl.engine.geom.Edge):Array<{ public var layerIndex(default, default) : Int; public var edge(default, default) : nanofl.engine.geom.Edge; }>;
	function getEdgeAtPos(pos:nanofl.engine.geom.Point):{ var edge : nanofl.engine.geom.Edge; var layerIndex : Int; };
	function translateVertex(point:nanofl.engine.geom.Point, dx:Float, dy:Float):Void;
	function hasSelected():Bool;
	function hasSelectedEdges():Bool;
	function hasSelectedPolygons():Bool;
	function updateShapes():Void;
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
	function getSelectedElements():Array<nanofl.ide.editor.FigureElement>;
	function selectAll():Void;
	function deselectAll():Void;
	function getBounds(?bounds:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	function getSelectedBounds(?bounds:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	function removeSelected():Void;
	function translateSelected(dx:Float, dy:Float):Void;
	function transformSelected(m:nanofl.engine.geom.Matrix):Void;
	function setSelectedPolygonsFillParams(params:nanofl.engine.fills.FillParams):Void;
	function setSelectedEdgesStrokeParams(params:nanofl.engine.strokes.StrokeParams):Void;
	function setSelectedPolygonsFill(fill:nanofl.engine.fills.IFill, ?x1:Float, ?y1:Float, ?x2:Float, ?y2:Float):Void;
	function setSelectedEdgesStroke(stroke:nanofl.engine.strokes.IStroke):Void;
	function combineSelf():Void;
	function combineSelected():Void;
	function extractSelected():nanofl.engine.elements.ShapeElement;
	function getMagnetPointEx(x:Float, y:Float, ?excludeSelf:Bool):{ var found : Bool; var point : nanofl.engine.geom.Point; };
	function splitEdge(edge:nanofl.engine.geom.Edge, t:Float):nanofl.engine.geom.Point;
	function getSelectedStrokeEdges():Array<nanofl.engine.geom.StrokeEdge>;
	function getStrokeEdgeOrPolygonAtPos(pos:nanofl.engine.geom.Point):{ var layerIndex : Int; var obj : haxe.extern.EitherType<nanofl.engine.geom.StrokeEdge, nanofl.engine.geom.Polygon>; };
}