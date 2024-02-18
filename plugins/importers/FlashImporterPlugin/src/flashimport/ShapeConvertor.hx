package flashimport;

import nanofl.engine.fills.IFill;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Contours;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.strokes.IStroke;
import stdlib.Debug;
using Lambda;

typedef FillContour = { fill:IFill, contour:Contour };

class ShapeConvertor
{
	var stokes : Array<IStroke>;
	var fills : Array<IFill>;
	var edgeDatas : Array<EdgeData>;
	
	public function new(stokes:Array<IStroke>, fills:Array<IFill>, edgeDatas:Array<EdgeData>)
	{
		this.stokes = stokes;
		this.fills = fills;
		this.edgeDatas = edgeDatas;
	}
	
	public function convert() : { edges:Array<StrokeEdge>, polygons:Array<Polygon>}
	{
		var strokeAndFillEdges = parseEdges();
		
		var fillContours = findFillContours(strokeAndFillEdges.fillEdges);
		
		log(function() return "EdgeDataConvertor.convert(1) fillContours =\n\t" + fillContours.map(function(fc) return StringTools.rpad(Std.string(fc.fill), " ", 35) + " / " + fc.contour.getClockwiseProduct() + " / " + fc.contour).join("\n\t"));
		
		return
		{
			edges: strokeAndFillEdges.strokeEdges,
			polygons: polygonsFromFillContours(fillContours)
		};
	}
	
	function parseEdges() : { strokeEdges:Array<StrokeEdge>, fillEdges:Array<{ edge:Edge, fill:IFill }> }
	{
		var strokeEdges = new Array<StrokeEdge>();
		
		var fillEdges = new Array<{ edge:Edge, fill:IFill }>();
		
		var posX = 0.0;
		var posY = 0.0;
		
		for (edgeData in edgeDatas)
		{
			var stroke = edgeData.strokeStyle != 0 ? stokes[edgeData.strokeStyle - 1] : null;
			var fill0  = edgeData.fillStyle0  != 0 ?  fills[edgeData.fillStyle0  - 1] : null; // outer fill
			var fill1  = edgeData.fillStyle1  != 0 ?  fills[edgeData.fillStyle1  - 1] : null; // inner fill
			
			for (drawOp in edgeData.drawOps)
			{
				switch(drawOp)
				{
					case DrawOp.move(x, y):
						posX = x;
						posY = y;
					
					case DrawOp.line(x, y):
						var edge = new Edge(posX, posY, x, y);
						
						if (stroke != null) strokeEdges.push(StrokeEdge.fromEdge(edge, stroke));
						if (fill0 != null || fill1 != null)
						{
							fillEdges.push({ edge:edge, fill:fill0 });
							fillEdges.push({ edge:edge.clone().reverse(), fill:fill1 });
						}
						
						posX = x;
						posY = y;
						
					case DrawOp.curve(x1, y1, x2, y2):
						var edge = new Edge(posX, posY, x1, y1, x2, y2);
						
						if (stroke != null) strokeEdges.push(StrokeEdge.fromEdge(edge, stroke));
						if (fill0 != null || fill1 != null)
						{
							fillEdges.push({ edge:edge, fill:fill0 });
							fillEdges.push({ edge:edge.clone().reverse(), fill:fill1 });
						}
						
						posX = x2;
						posY = y2;
				}
			}
		}
		
		log(function() return "EdgeDataConvertor.parseEdges fillEdges =\n\t" + fillEdges.map(function(fe) return StringTools.rpad(Std.string(fe.fill), " ", 35) + " / " + fe.edge).join("\n\t"));
		
		return { strokeEdges:strokeEdges, fillEdges:fillEdges };
	}
	
	function findFillContours(fillEdges:Array<{ edge:Edge, fill:IFill }>) : Array<FillContour>
	{
		var r = new Array<FillContour>();
		
		while (fillEdges.length > 0)
		{
			var base = fillEdges.shift();
			var edges = [ base.edge ];
			var i = 0; while (i < fillEdges.length)
			{
				if (fillEdges[i].fill == base.fill)
				{
					edges.push(fillEdges[i].edge);
					fillEdges.splice(i, 1);
				}
				else
				{
					i++;
				}
			}
			var contours = Contours.fromVectors(edges);
			for (contour in contours)
			{
				var c = r.find(function(c) return c.contour.equ(contour));
				if (c == null) r.push({ fill:base.fill, contour:contour });
				else
				if (c.fill == null) c.fill = base.fill;
			}
		}
		
		return r;
	}
	
	function polygonsFromFillContours(fillContours:Array<FillContour>) : Array<Polygon>
	{
		assertFillContoursCorrect(fillContours);
		
		for (fc in fillContours)
		{
			if (fc.contour.getClockwiseProduct() < 0) fc.contour.reverse();
		}
		
		assertFillContoursCorrect(fillContours);
		
		var r = [];
		for (outer in fillContours)
		{
			if (outer.fill == null) continue;
			
			var inners = [];
			for (inner in fillContours)
			{
				if (inner != outer && inner.contour.isNestedTo(outer.contour))
				{
					Debug.assert(inner.contour != outer.contour);
					Debug.assert(!inner.contour.equ(outer.contour));
					inners.push(inner.contour.clone().reverse());
				}
			}
			
			Contours.removeNested(inners);
			Contours.mergeByCommonEdges(inners, true);
			
			var polygon = new Polygon(outer.fill, [ outer.contour ].concat(inners));
			polygon.assertCorrect();
			r.push(polygon);
		}
		
		return r;
	}
	
	function assertFillContoursCorrect(fillContours:Array<FillContour>)
	{
		for (fc in fillContours) fc.contour.assertCorrect();
		var i = 0; while (i < fillContours.length)
		{
			var j = i + 1; while (j < fillContours.length)
			{
				if (fillContours[i].contour.equ(fillContours[j].contour))
				{
					trace("Equ contours:\n\tfill[i] = " + fillContours[i].fill + "\n\tfill[j] = " + fillContours[j].fill + "\n\tcontour = " + fillContours[i].contour);
				}
				j++;
			}
			i++;
		}
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
