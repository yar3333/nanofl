package nanofl.engine.geom;

import datatools.ArrayTools;
import nanofl.engine.fills.IFill;
import stdlib.Debug;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
class Polygons
{
	public static function findByPoint(polygons:Array<Polygon>, x:Float, y:Float) : Polygon
	{
		for (p in polygons)
		{
			if (p.isPointInside(x, y)) return p;
		}
		return null;
	}
	
	public static function isEdgeInside(polygons:Array<Polygon>, edge:Edge) : Bool
	{
		for (p in polygons)
		{
			if (p.isEdgeInside(edge)) return true;
		}
		return false;
	}
	
	public static function mergeByCommonEdges(polygons:Array<Polygon>, edges:Array<StrokeEdge>) : Void
	{
		Debug.assert(!Polygons.hasDublicates(polygons));
		Polygons.assertCorrect(polygons, false);
		
		log(function() return "mergeByCommonEdges\npolygons =\n" + polygons.map(function(p) return "\t" + p).join("\n") + "\nedges = " + edges.join("; "));
		
		// check existing common edges in outer contours
		var i = 0; while (i < polygons.length)
		{
			var j = i + 1; while (j < polygons.length)
			{
				log(function() return 'test i=$i and j=$j\n\t\t' + polygons[i].toString() + "\n\t\t" + polygons[j]);
				if (polygons[i].fill.equ(polygons[j].fill))
				{
					log(function() return '\tfill match!');
					Debug.assert(polygons[i].contours.length > 0);
					Debug.assert(polygons[j].contours.length > 0);
					
					var commonEdges = Edges.getCommon(polygons[i].contours[0].edges, polygons[j].contours[0].edges);
					log(function() return '\tcommonEdges = ' + commonEdges);
					if (commonEdges.length > 0 && commonEdges.foreach(function(e) return e.indexIn(edges) < 0))
					{
						var outerEdges = Edges.exclude(Edges.concatUnique(polygons[i].contours[0].edges, polygons[j].contours[0].edges), commonEdges);
						
						log("\tMERGE!");
						if (outerEdges.length > 0)
						{
							//log(function() return ">>>outerEdges = " + outerEdges);
							var outerContours = Contours.fromEdges(outerEdges);
							outerContours.sort(function(a, b) return a.isNestedTo(b) ? 1 : -1);
							for (k in 1...outerContours.length) outerContours[k].reverse();
							//log(function() return ">>>outerContours =\n" + outerContours.join("\n"));
							
							var inners = outerContours.slice(1).concat(polygons[i].contours.slice(1)).concat(polygons[j].contours.slice(1));
							Contours.removeNested(inners);
							Contours.mergeByCommonEdges(inners, true);
							
							polygons[i] = new Polygon
							(
								polygons[i].fill,
								[ outerContours[0] ].concat(inners)
							);
							
							polygons[i].assertCorrect();
						}
						else
						{
							Debug.assert(false, function() return "Two polygons with same outer contour = " + polygons[i].contours[0]);
						}
						//log(function() return "(1) RESULT\n" + polygons[i].toString());
						
						log("\tRemove polygon " + j);
						polygons.splice(j, 1);
						
						if (outerEdges.length > 0) j = i;	// if p[i] changed => need recheck p[i] with all p[j] where j>i
						else                       j--;		// p[j] is equ p[i] because all edges are common
						
						log("\tj = " + j);
					}
				}
				j++;
			}
			i++;
		}
		
		log("==================================== in the middle ==========================");
		log(function() return "// SOURCE:\n\t" + polygons.join("\n\t"));
		
		Polygons.assertCorrect(polygons, false);
		
		// check polygon j inside hole of i and has common edge with a hole contour
		var i = 0; while (i < polygons.length)
		{
			var j = 0; while (j < polygons.length)
			{
				if (i != j && polygons[i].fill.equ(polygons[j].fill))
				{
					Debug.assert(polygons[i].contours.length > 0);
					Debug.assert(polygons[j].contours.length > 0);
					
					var outerJ = polygons[j].contours[0];
					
					for (k in 1...polygons[i].contours.length)
					{
						var innerI = polygons[i].contours[k];
						
						var commonEdges = Edges.getCommon(innerI.edges, outerJ.edges);
						log(function() return "\tcommonEdges = " + commonEdges);
						if (commonEdges.length > 0 && commonEdges.foreach(function(e) return e.indexIn(edges) < 0))
						{
							var innerEdges = Edges.exclude(Edges.concatUnique(innerI.edges, outerJ.edges), commonEdges);
							log(function() return "\tinnerEdges = " + innerEdges);
							
							log(function() return '// MERGE $i and $j\n\t' + polygons[i] + "\n\t" + polygons[j]);
							
							polygons[i].contours.splice(k, 1);
							
							if (innerEdges.length > 0)
							{
								var inners = Contours.fromEdges(innerEdges);
								for (c in inners) c.reverse();
								inners = inners.concat(polygons[j].contours.slice(1));
								polygons[i].contours = polygons[i].contours.concat(inners);
								polygons[i].assertCorrect();
							}
							else
							{
								polygons[i].contours = polygons[i].contours.concat(polygons[j].contours.slice(1));
								polygons[i].assertCorrect();
							}
							
							log(function() return "// RESULT\n\t" + polygons[i]);
							
							polygons.splice(j, 1);
							if (i > j) i--;
							j = -1;
							break;
						}
					}
				}
				j++;
			}
			i++;
		}
		
		Polygons.assertCorrect(polygons, true);
	}
	
	public static function removeDublicates(polygons:Array<Polygon>) : Void
	{
		var i = 0; while (i < polygons.length)
		{
			var j = i + 1; while (j < polygons.length)
			{
				if (polygons[i].equ(polygons[j]))
				{
					polygons[i].fill = polygons[j].fill;
					polygons.splice(j, 1);
				}
				else
				{
					j++;
				}
			}
			i++;
		}
	}
	
	static function hasDublicates(polygons:Array<Polygon>) : Bool
	{
		for (i in 0...polygons.length)
		{
			for (j in i + 1...polygons.length)
			{
				if (polygons[i].equ(polygons[j])) return true;
			}
		}
		return false;
	}
	
	public static function normalize(polygons:Array<Polygon>) : Void
	{
		var i = 0; while (i < polygons.length)
		{
			polygons[i].normalize();
			if (polygons[i].contours.length == 0) polygons.splice(i, 1);
			else i++;
		}
		
		log("normalize > removeDublicates vvvvvvvvvvv");
		removeDublicates(polygons);
		log("normalize > removeDublicates ^^^^^^^^^^^");
		
		if (hasDublicates(polygons)) trace("normalize > DUPS DETECTED!!!!!!!");
	}
	
	public static function getEdges(polygons:Array<Polygon>) : Array<Edge>
	{
		var r = [];
		
		for (polygon in polygons)
		{
			for (contour in polygon.contours)
			{
				Edges.appendUnique(r, contour.edges);
			}
			}
		return r;
	}
	
	public static function getByPoint(polygons:Array<Polygon>, pos:Point) : Polygon
	{
		var i = polygons.length - 1; while (i >= 0)
		{
			if (polygons[i].isPointInside(pos.x, pos.y)) return polygons[i];
			i--;
		}
		return null;
	}
	
	@:profile
	public static function fromEdges(edges:Array<Edge>, strokeEdges:Array<StrokeEdge>, polygonsToDetectFill:Array<Polygon>) : Array<Polygon>
	{
		Debug.assert(!Edges.hasDegenerated(edges), "Degenerated edges detected.");
		Debug.assert(!Edges.hasDuplicates(edges), "Duplicated edges detected.");
		Debug.assert(!Edges.hasDuplicates(strokeEdges), "Duplicated strokeEdges detected.");
		
		log(function() return "Polygons.getReconstructed vvvvvvvvvvvvvvvvvvvvvvvv");
		
		var contours = Contours.fromEdges(edges);
		
		var r = fromContours(contours, strokeEdges, function(polygon:Polygon) : IFill
		{
			var pt = polygon.getPointInside();
			var original = getByPoint(polygonsToDetectFill, pt);
			return original != null ? original.fill : null;
		});
		
		log(function() return "Polygons.getReconstructed ^^^^^^^^^^^^^^^^^^^^^^^^ result =\n\t" + r.join(";\n\t"));
		
		return r;
	}
	
	@:profile
	static function fromContours(contours:Array<Contour>, strokeEdges:Array<StrokeEdge>, getFill:Polygon->IFill) : Array<Polygon>
	{
		var r = [];
		
		for (outer in contours)
		{
			var inners = [];
			for (inner in contours)
			{
				if (inner != outer && inner.isNestedTo(outer))
				{
					inners.push(inner.clone().reverse());
				}
			}
			
			//log(function() return ">>>OUTER = " + outer);
			//log(function() return ">>>INNERS =\n" + inners.join("\n") + "\n");
			
			Contours.removeNested(inners);
			Contours.mergeByCommonEdges(inners, true);
			
			var polygon = new Polygon([ outer ].concat(inners));
			polygon.assertCorrect();
			
			var fill = getFill(polygon);
			if (fill != null)
			{
				polygon.fill = fill;
				r.push(polygon);
			}
		}
		
		mergeByCommonEdges(r, strokeEdges);
		
		return r;
	}
	
	@:profile
	public static function fromRawContours(originalContours:Array<Contour>, fill:IFill, fillEvenOdd:Bool) : Array<Polygon>
	{
		//try
		//{
			return fromRawContoursInner(originalContours, fill, fillEvenOdd);
		//}
		//catch (e:Dynamic)
		//{
		//	trace("ERROR: Polygons.fromContours(" + originalContours + ", " + fillEvenOdd + ")\n" + Exception.string(e));
		//	Exception.rethrow(e);
		//	return null;
		//}
	}
	
	static function fromRawContoursInner(originalContours:Array<Contour>, fill:IFill, fillEvenOdd:Bool) : Array<Polygon>
	{
		var edges = Contours.getEdges(originalContours);
		
		//log(function() return "\n\nPolygons.fromContours vvvvvvvvvvvvvvvvvvvvvvvvv fillEvenOdd = " + fillEvenOdd + "; originalContours = " + originalContours);
		log(function() return "\n\nPolygons.fromContours vvvvvvvvvvvvvvvvvvvvvvvvv edges = " + edges.length);
		
		var originalContoursNormalized = new Map<Contour, Array<Contour>>();
		for (c in originalContours)
		{
			var ee = c.edges.copy();
			Edges.normalize(ee);
			Edges.intersectSelf(ee);
			originalContoursNormalized.set(c, Contours.fromEdges(ee));
		}
		
		Debug.assert(edges.indexOf(null) < 0);
		
		Edges.normalize(edges);
		
		Edges.intersectSelf(edges);
		
		var contours = Contours.fromEdges(edges);
		
		var r = fromContours(contours, [], function(polygon:Polygon) : IFill
		{
			var pt = polygon.getPointInside();
			
			// MUST KEEP DUPLICATES!!!
			var edgesToTestFilling = [];
			for (contour in originalContours)
			{
				if (originalContoursNormalized.get(contour).exists(function(c) return c.isPointInsideP(pt)))
				{
					edgesToTestFilling = edgesToTestFilling.concat(contour.edges);
				}
			}
			
			return Edges.isPointInside(edgesToTestFilling, pt.x, pt.y, fillEvenOdd) ? fill : null;
		});
		
		log(function() return "Polygons.fromContours ^^^^^^^^^^^^^^^^^^^^^^^^^");
		
		return r;
	}
	
	static function getEdgesToTestFilling(originals:Array<Edge>, edges:Array<Edge>) : Array<Edge>
	{
		var r = [];
		
		for (edge in originals)
		{
			if (r.indexOf(edge) < 0 && edge.indexIn(edges) >= 0)
			{
				r.push(edge);
			}
		}
		
		return r;
	}
	
	@:profile
	public static function assertCorrect(polygons:Array<Polygon>, intergrityChecks:Bool, ?message:Dynamic)
	{
		#if long_asserts
		
		for (p in polygons) p.assertCorrect();
		
		if (intergrityChecks)
		{
			Debug.assert(!hasDublicates(polygons), function() return "Has duplicates\n" + (Reflect.isFunction(message) ? message() : message));
			
			Edges.assertHasNoIntersections(Polygons.getEdges(polygons));
			
			for (p1 in polygons)
			{
				for (p2 in polygons)
				{
					Debug.assert(p1 == p2 || p1.isContourOutside(p2.contours[0]), function() return "One polygon inside other\n" + p1 + "\n" + p2 + "\n" + (Reflect.isFunction(message) ? message() : message));
				}
			}
		}
		
		#end
	}
	
    #if ide
	public static function removeErased(polygons:Array<Polygon>)
	{
		var i = 0; while (i < polygons.length)  
		{
			if (Std.isOfType(polygons[i].fill, nanofl.engine.fills.EraseFill))
			{
				polygons.splice(i, 1);
			}
			else
			{
				i++;
			}
		}
	}
    #end
	
	/**
	 * Compare with fill testing.
	 */
	public static function equ(a:Array<Polygon>, b:Array<Polygon>) : Bool
	{
		return ArrayTools.equ(a, b) && ArrayTools.equ(a.map(x -> x.fill), b.map(x -> x.fill));
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
