package nanofl.ide.editor;

import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.FillParams;
import nanofl.engine.fills.IFill;
import nanofl.engine.geom.Bounds;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.strokes.IStroke;
import nanofl.engine.strokes.StrokeParams;
import nanofl.ide.editor.EditorLayer;
import nanofl.ide.editor.Editor;
import nanofl.ide.undo.states.FigureState;
import stdlib.Debug;
using nanofl.engine.geom.PointTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
class Figure
{
	var editor : Editor;
	var layers : Array<EditorLayer>;
	
	public function new(editor:Editor, layers:Array<EditorLayer>)
	{
		this.editor = editor;
		this.layers = layers;
	}
	
	public function getSameEdgeWithLayers(edge:Edge) : Array<{ edge:Edge, layerIndex:Int }>
	{
		var r = [];
		
		for (layer in editor.getEditableLayers())
		{
			for (edge in layer.shape.element.getSameEdges(edge))
			{
				r.push({ edge:edge, layerIndex:layer.getIndex() });
			}
		}
		
		return r;
	}
	
	public function getEdgeAtPos(pos:Point) : { edge:Edge, layerIndex:Int }
	{
		for (layer in editor.getEditableLayers())
		{
			var r = layer.getEdgeAtPos(pos);
			if (r != null) return { edge:r, layerIndex:layer.getIndex() };
		}
		return null;
	}
	
	
	public function translateVertex(point:Point, dx:Float, dy:Float)
	{
		for (shape in getEditableShapes())
		{
			shape.translateVertex(point, dx, dy);
		}
	}
	
	public function hasSelected() : Bool
	{
		return getEditableShapes().exists(x -> x.hasSelected());
	}
	
	public function hasSelectedEdges() : Bool
	{
		return getEditableShapes().exists(x -> x.hasSelectedEdges());
	}
	
	public function hasSelectedPolygons() : Bool
	{
		return getEditableShapes().exists(x -> x.hasSelectedPolygons());
	}
	
	@:profile
	public function updateShapes()
	{
		for (layer in editor.getEditableLayers())
		{
			layer.shape.update();
		}
	}
	
	@:profile
	public function getSelectedEdgesStrokeParams() : {>StrokeParams, type:String }
	{
		var r =
		{
			type: null,
			thickness: null,
			ignoreScale: null,
			color: null,
			colors: null,
			ratios: null,
			x0: null,
			y0: null,
			x1: null,
			y1: null,
			r: null,
			bitmapPath: null,
			caps: null,
			joints: null,
			miterLimit: null
		};
		
		for (shape in getEditableShapes())
		{
			var params = shape.getSelectedEdgesStrokeParams();
			if (params.type != null) r.type = r.type == null || r.type == params.type ? params.type : "mixed";
			if (params.thickness != null) r.thickness = params.thickness;
			if (params.ignoreScale != null) r.ignoreScale = params.ignoreScale;
			if (params.color != null) r.color = params.color;
			if (params.colors != null) r.colors = params.colors;
			if (params.ratios != null) r.ratios = params.ratios;
			if (params.x0 != null) r.x0 = params.x0;
			if (params.y0 != null) r.y0 = params.y0;
			if (params.x1 != null) r.x1 = params.x1;
			if (params.y1 != null) r.y1 = params.y1;
			if (params.r != null) r.r = params.r;
			if (params.bitmapPath != null) r.bitmapPath = params.bitmapPath;
			if (params.caps != null) r.caps = params.caps;
			if (params.joints != null) r.joints = params.joints;
			if (params.miterLimit != null) r.miterLimit = params.miterLimit;
		}
		
		return r;
	}
	
	@:profile
	public function getSelectedPolygonsFillParams() : {>FillParams, type:String }
	{
		var r = { type:null, color:null, colors:null, ratios:null, matrix:null, bitmapPath:null, repeat:null };
		
		for (shape in getEditableShapes())
		{
			var z = shape.getSelectedPolygonsFillParams();
			if (z.type != null) r.type = r.type == null || r.type == z.type ? z.type : "mixed";
			if (z.color			!= null) r.color = z.color;
			if (z.colors		!= null) r.colors = z.colors;
			if (z.ratios		!= null) r.ratios = z.ratios;
			if (z.matrix		!= null) r.matrix = z.matrix;
			if (z.bitmapPath	!= null) r.bitmapPath = z.bitmapPath;
			if (z.repeat		!= null) r.repeat = z.repeat;
		}
		
		return r;
	}
	
	public function getSelectedElements() : Array<FigureElement>
	{
		var r = [];
		for (shape in getEditableShapes())
		{
			for (edge in shape.edges)
			{
				if (edge.selected) r.push(FigureElement.STROKE_EDGE(edge));
			}
			for (polygon in shape.polygons)
			{
				if (polygon.selected) r.push(FigureElement.POLYGON(polygon));
			}
		}
		return r;
	}
	
	public function selectAll()
	{
		for (shape in getEditableShapes())
		{
			shape.selectAll();
		}
	}
	
	public function deselectAll()
	{
		for (shape in getEditableShapes())
		{
			shape.deselectAll();
		}
	}
	
	public function getBounds(?bounds:Bounds) : Bounds
	{
		if (bounds == null)
		{
			bounds = { minX:1e10, minY:1e10, maxX: -1e10, maxY: -1e10 };
		}
		
		for (shape in getEditableShapes())
		{
			shape.getBounds(bounds);
		}
		
		return bounds;
	}
	
	public function getSelectedBounds(?bounds:Bounds) : Bounds
	{
		if (bounds == null)
		{
			bounds = { minX:1e10, minY:1e10, maxX: -1e10, maxY: -1e10 };
		}
		
		for (shape in getEditableShapes())
		{
			shape.getSelectedBounds(bounds);
		}
		
		return bounds;
	}
	
	@:profile
	public function removeSelected()
	{
		for (shape in getEditableShapes())
		{
			shape.removeSelected();
		}
	}
	
	public function translateSelected(dx:Float, dy:Float)
	{
		for (shape in getEditableShapes())
		{
			shape.translateSelected(dx, dy);
		}
	}
	
	public function transformSelected(m:Matrix)
	{
		for (shape in getEditableShapes())
		{
			shape.transformSelected(m, false);
		}
	}
	
	public function setSelectedPolygonsFillParams(params:FillParams)
	{
		for (shape in getEditableShapes())
		{
			shape.setSelectedPolygonsFillParams(params);
		}
	}
	
	public function setSelectedEdgesStrokeParams(params:StrokeParams)
	{
		for (shape in getEditableShapes())
		{
			shape.setSelectedEdgesStrokeParams(params);
		}
	}
	
	public function setSelectedPolygonsFill(fill:IFill, ?x1:Float, ?y1:Float, ?x2:Float, ?y2:Float)
	{
		for (shape in getEditableShapes())
		{
			shape.setSelectedPolygonsFill(fill, x1, y1, x2, y2);
		}
	}
	
	public function setSelectedEdgesStroke(stroke:IStroke)
	{
		for (shape in getEditableShapes())
		{
			shape.setSelectedEdgesStroke(stroke);
		}
	}
	
	public function combineSelf()
	{
		for (shape in getEditableShapes())
		{
			shape.combineSelf();
		}
	}
	
	public function combineSelected()
	{
		for (shape in getEditableShapes())
		{
			shape.combineSelected();
		}
	}
	
	@:profile
	@:allow(nanofl.ide.undo)
	function getState() : FigureState
	{
		return new FigureState(layers.map(x -> x.shape != null ? cast x.shape.element.getState() : null));
	}
	
	@:profile
	@:allow(nanofl.ide.undo)
	function setState(state:FigureState)
	{
		Debug.assert(layers.length == state.shapeStates.length, "layers.length = " + layers.length + ", state.shapeStates.length = " + state.shapeStates.length);
		
		for (i in 0...layers.length)
		{
			if (layers[i].shape != null)
			{
				layers[i].shape.element.setState(state.shapeStates[i]);
			}
		}
	}
	
	public function extractSelected() : ShapeElement
	{
		var r = new ShapeElement();
		for (shape in getEditableShapes())
		{
			r.combine(shape.extractSelected());
		}
		return r;
	}
	
	public function getMagnetPointEx(x:Float, y:Float, excludeSelf=false) : { point:Point, found:Bool }
	{
		var pt = { x:x, y:y };
		
		var r : { point:Point, dist:Float, distMinusEdgeThickness:Float } = null;
		for (shape in getEditableShapes())
		{
			var m = shape.getNearestVertex(pt, excludeSelf);
			if (m != null && (r == null || m.dist < r.dist)) r = m;
		}
		
		return r != null && r.distMinusEdgeThickness < editor.getHitTestGap()
			? { point:r.point, found:true }
			: { point:pt, found:false };
	}
	
	public function splitEdge(edge:Edge, t:Float) : Point
	{
		var edges = edge.split([ t ]);
		if (edges == null) return null;
		for (shape in getEditableShapes())
		{
			shape.replaceEdge(edge, edges);
		}
		return { x:edges[0].x3, y:edges[0].y3 };
	}
	
	public function getSelectedStrokeEdges() : Array<StrokeEdge>
	{
		var r = [];
		for (shape in getEditableShapes())
		{
			for (edge in shape.edges)
			{
				if (edge.selected) r.push(edge);
			}
		}
		return r;
	}
	
	public function getStrokeEdgeOrPolygonAtPos(pos:Point) : { obj:haxe.extern.EitherType<StrokeEdge, Polygon>, layerIndex:Int }
	{
		for (layer in editor.getEditableLayers())
		{
			var r : haxe.extern.EitherType<StrokeEdge, Polygon> = layer.getStrokeEdgeAtPos(pos);
			if (r == null) r = layer.getPolygonAtPos(pos);
			if (r != null) return { obj:r, layerIndex:layer.getIndex() };
		}
		return null;
	}
	
	function getEditableShapes() : Array<ShapeElement>
	{
		return editor.getEditableLayers().map(x -> x.shape.element);
	}
}