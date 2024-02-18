package nanofl.engine.geom;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import datatools.ArrayTools;
import nanofl.engine.strokes.IStroke;
import nanofl.engine.strokes.SelectionStroke;
import stdlib.Debug;
using htmlparser.HtmlParserTools;
using stdlib.Lambda;

class StrokeEdges
{
	public static function load(nodes:Array<HtmlNodeElement>, strokes:Array<IStroke>, version:String) : Array<StrokeEdge>
	{
        var r = new Array<StrokeEdge>();
        
        for (node in nodes)
        {
            Debug.assert(node.name == "edge");
            var strokeIndex = Std.int(node.getAttr("strokeIndex", -1));
            Debug.assert(strokeIndex >= 0);
            Debug.assert(strokeIndex < strokes.length);

            var edges = Edges.load(node.getAttribute("edges"));
            r.addRange(edges.map(edge ->StrokeEdge.fromEdge(edge, strokes[strokeIndex])));
        }

        return r;
	}

	public static function loadJson(objs:Array<Dynamic>, strokes:Array<IStroke>, version:String) : Array<StrokeEdge>
	{
        var r = new Array<StrokeEdge>();
		
        for (obj in objs)
        {
            //Debug.assert(obj.name == "edge");
            var strokeIndex = obj.strokeIndex ?? -1;
            Debug.assert(strokeIndex >= 0);
            Debug.assert(strokeIndex < strokes.length);

            var edges = Edges.load(obj.edges);
            r.addRange(edges.map(edge ->StrokeEdge.fromEdge(edge, strokes[strokeIndex])));
        }

        return r;
	}
	
	public static function save(edges:Array<StrokeEdge>, strokes:Array<IStroke>, out:XmlBuilder)
	{
		var groups = getStrokeGroups(edges, strokes);
		for (i in 0...groups.length)
		{
			out.begin("edge").attr("strokeIndex", i);
			out.attr("edges", Edges.save(groups[i]));
			out.end();
		}
	}
	
	public static function saveJson(edges:Array<StrokeEdge>, strokes:Array<IStroke>) : Array<Dynamic>
	{
        var arr = new Array<Dynamic>();

		var groups = getStrokeGroups(edges, strokes);
		for (i in 0...groups.length)
		{
			arr.push
            ({
                strokeIndex: i,
                edges: Edges.save(groups[i]),
            });
		}
        
        return arr;
	}
	
	static function getStrokeGroups(edges:Array<StrokeEdge>, strokes:Array<IStroke>) : Array<Array<Edge>>
	{
		var groups = new Array<Array<Edge>>();
		for (i in 0...strokes.length) groups.push([]);
		for (e in edges)
		{
			var index = strokes.findIndex(function(stroke) return stroke.equ(e.stroke));
			groups[index].push(e);
		}
		return groups;
	}
	
	public static function getBounds(edges:Array<StrokeEdge>, ?bounds:Bounds) : Bounds
	{
		if (edges.length > 0)
		{
			if (bounds == null) bounds = { minX:1e100, minY:1e100, maxX:-1e100, maxY:-1e100 };
			for (e in edges)
			{
				var b = e.getBounds();
				var r = e.stroke.thickness / 2;
				bounds.minX = Math.min(bounds.minX, b.minX - r);
				bounds.minY = Math.min(bounds.minY, b.minY - r);
				bounds.maxX = Math.max(bounds.maxX, b.maxX + r);
				bounds.maxY = Math.max(bounds.maxY, b.maxY + r);
			}
		}
		return bounds;
	}
	
	public static function duplicateStrokes(edges:Array<StrokeEdge>) : Array<IStroke>
	{
		var processed = new Map<IStroke, IStroke>();
		for (e in edges)
		{
			var stroke = processed.get(e.stroke);
			if (stroke == null)
			{
				stroke = e.stroke.clone();
				processed.set(e.stroke, stroke); 
			}
			e.stroke = stroke;			
		}
		return processed.array();
	}
	
	public static function drawSorted(edges:Array<StrokeEdge>, g:ShapeRender, scaleSelection:Float) : Void
	{
		sort(edges);
		
		var i = 0; while (i < edges.length)
		{
			var j = i + 1; while (j < edges.length && edges[i].stroke.equ(edges[j].stroke)) j++;
			edges[i].stroke.begin(g);
			Edges.draw(edges.slice(i, j), g, true);
			g.endStroke();
			i = j;
		}
		
		if (Edges.showSelection)
		{
			edges = edges.filter(function(e) return e.selected);
			if (edges.length > 0)
			{
				var i = 0; while (i < edges.length)
				{
					var j = i + 1; while (j < edges.length && edges[i].stroke.equ(edges[j].stroke)) j++;
					new SelectionStroke(edges[i].stroke, scaleSelection).begin(g);
					Edges.draw(edges.slice(i, j), g, true);
					g.endStroke();
					i = j;
				}
			}
		}
	}
	
	static function sort(edges:Array<StrokeEdge>) : Void
	{
		var i = 1; while (i < edges.length)
		{
			while (i < edges.length && edges[i - 1].stroke.equ(edges[i].stroke)) i++;
			
			for (j in i...edges.length)
			{
				if (edges[i].stroke.equ(edges[j].stroke))
				{
					var z = edges[i];
					edges[i] = edges[j];
					edges[j] = z;
					i++;
				}
			}
			
			i++;
		}
		
		var i = 0; while (i < edges.length)
		{
			var j = i + 1; while (j < edges.length && edges[i].stroke.equ(edges[j].stroke)) j++;
			sortToProduceSequences(edges, i, j);
			i = j;
		}
	}
	
	static function sortToProduceSequences(edges:Array<StrokeEdge>, from:Int, to:Int)
	{
		var lastSorted = from;
		
		var i = lastSorted + 1; while (i < to)
		{
			//trace('from = $from, to = $to, i = $i, lastSorted = $lastSorted');
			if (lastSorted + 1 < to
			 && edges[lastSorted].x3 == edges[i].x1
			 && edges[lastSorted].y3 == edges[i].y1)
			{
				ArrayTools.swap(edges, lastSorted + 1, i);
				lastSorted++;
				i = lastSorted + 1;
			}
			else
			if (lastSorted + 1 < to
			 && edges[lastSorted].x3 == edges[i].x3
			 && edges[lastSorted].y3 == edges[i].y3)
			{
				edges[i].reverse();
				ArrayTools.swap(edges, lastSorted + 1, i);
				lastSorted++;
				i = lastSorted + 1;
			}
			else
			if (edges[from].x1 == edges[i].x3
			 && edges[from].y1 == edges[i].y3)
			{
				var z = edges[i];
				var k = i; while (k > from)
				{
					edges[k] = edges[k - 1];
					k--;
				}
				edges[from] = z;
				lastSorted++;
				i = lastSorted + 1;
			}
			else
			if (edges[i].x1 == edges[from].x1
			 && edges[i].y1 == edges[from].y1)
			{
				edges[i].reverse();
				var z = edges[i];
				var k = i; while (k > from)
				{
					edges[k] = edges[k - 1];
					k--;
				}
				edges[from] = z;
				lastSorted++;
				i = lastSorted + 1;
			}
			else
			{
				i++;
			}
		}
		
		if (lastSorted + 2 < to) sortToProduceSequences(edges, lastSorted + 1, to);
	}
	
	public static function fromEdges(edges:Array<Edge>, stroke:IStroke, selected=false) : Array<StrokeEdge>
	{
		return edges.map(function(e) return StrokeEdge.fromEdge(e, stroke, selected));
	}
	
	public static function replace(edges:Array<StrokeEdge>, search:Edge, replacement:Array<Edge>)
	{
		Edges.replace(edges, search, replacement.filter(function(e) return e.indexIn(edges) < 0));
	}
	
	/**
	 * Compare with stroke testing.
	 */
	public static function equ(a:Array<StrokeEdge>, b:Array<StrokeEdge>) : Bool
	{
		return ArrayTools.equ(a, b) && ArrayTools.equ(a.map(x -> x.stroke), b.map(x -> x.stroke));
	}
}