package nanofl.engine.geom;

import haxe.ds.Vector;
import stdlib.Debug;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
class Contours
{
	@:profile
	public static function fromEdges(edges:Array<Edge>) : Array<Contour>
	{
		log(function() return "Contours.find(1): edges = " + edges.length);
		
		Debug.assert(!Edges.hasDegenerated(edges), "Degenerated edges detected.");
		Debug.assert(!Edges.hasDuplicates(edges), "Duplicated edges detected.");
		
		edges = edges.copy();
		
		removeTailEdges(edges);
		
		log(function() return "Contours.find(2): edges = " + edges.length + "; " + edges);
		
		var sequences = getSequencesFromEdges(edges);
		//log(function() return "sequences = \n" + sequences.join("\n"));
		
		var vectors : Array<Edge> = edges.copy();
		for (e in edges) vectors.push(e.clone().reverse());
		
		var connections = getConnections(vectors);
		var excludes = new Vector<Bool>(vectors.length);
		
		var r = new Array<Contour>();
		
		for (sequence in sequences)
		{
			find(sequence[0],                   vectors, connections, excludes, r);
			find(sequence[0].clone().reverse(), vectors, connections, excludes, r);
			
			if (sequence.length > 1)
			{
				find(sequence[sequence.length - 1],                   vectors, connections, excludes, r);
				find(sequence[sequence.length - 1].clone().reverse(), vectors, connections, excludes, r);
			}
		}
		
		log(function() return "Contours.find(3): r =\n" + r.join("\n"));
		
		for (contour in r) Debug.assert(contour.isClockwise());
		
		return r;
	}
	
	public static function fromVectors(vectors:Array<Edge>) : Array<Contour>
	{
		vectors = vectors.copy();
		
		removeTailEdges(vectors);
		
		var sequences = getSequencesFromVectors(vectors);
		//log(function() return "sequences = \n" + sequences.join("\n"));
		
		var connections = getConnections(vectors);
		var excludes = new Vector<Bool>(vectors.length);
		
		var r = new Array<Contour>();
		
		for (sequence in sequences)
		{
			find(sequence[0], vectors, connections, excludes, r);
			
			if (sequence.length > 1)
			{
				find(sequence[sequence.length - 1], vectors, connections, excludes, r);
			}
		}
		
		return r;
	}
	
	static function find(start:Edge, vectors:Array<Edge>, connections:Array<Array<Int>>, excludes:Vector<Bool>, r:Array<Contour>) : Void
	{
		var startIndex = vectors.findIndex(x -> x.equDirected(start));
		if (excludes[startIndex])
		{
			log("exclude(1) " + startIndex);
			return;
		}
		
		var indexes = [ startIndex ];
		
		log(function() return "!!!!!!!!!!! startIndex = " + startIndex + "; start = " + start + "; contours = " + r.length);
		var lastBestVectorIndex : Int = null;
		
		while (true)
		{
			var nextIndex = findNext(indexes[indexes.length - 1], vectors, connections, excludes, lastBestVectorIndex);
			if (nextIndex == null) break;
			lastBestVectorIndex = null;
			log(function() return "\tnextIndex = " + nextIndex + "; next = " + vectors[nextIndex]);
			
			Debug.assert(indexes.indexOf(nextIndex) < 0);
			
			var next = vectors[nextIndex];
			
			if (next.x3 == start.x1 && next.y3 == start.y1)
			{
				indexes.push(nextIndex);
				contourFound(indexes, vectors, excludes, r);
				break;
			}
			else
			{
				var n = indexes.findIndex(x -> vectors[x].x1 == next.x3 && vectors[x].y1 == next.y3);
				if (n >= 0)
				{
					Debug.assert(n >= 1);
					indexes.push(nextIndex);
					lastBestVectorIndex = indexes[n];
					contourFound(indexes.slice(n), vectors, excludes, r);
					indexes = indexes.slice(0, n);
					log(function() return "Found inner loop n = " + n + "; lastBestVectorIndex = " + lastBestVectorIndex);
				}
				else
				{
					indexes.push(nextIndex);
				}
			}
		}
		
	}
	
	static function contourFound(indexes:Array<Int>, vectors:Array<Edge>, excludes:Vector<Bool>, r:Array<Contour>)
	{
		var contour = new Contour(indexes.map(x -> vectors[x].clone()));
		if (contour.isClockwise() && !r.exists(x -> x.equ(contour)))
		{
			r.push(contour);
			for (index in indexes) excludes[index] = true;
		}
	}
	
	@:profile
	static function findNext(lastIndex:Int, vectors:Array<Edge>, connections:Array<Array<Int>>, excludes:Vector<Bool>, lastBestVectorIndex:Int) : Int
	{
		var nexts = connections[lastIndex];
		
		Debug.assert(nexts.length > 0, function() return "nexts = " + nexts + "; vectors = " + vectors);
		
		//log(function() return "nexts.length = " + nexts.length);
		
		var last = vectors[lastIndex];
		var lastTangent = last.getTangent(1) + Math.PI;
		//log(function() return "/* last = */" + last + " // tan = " + lastTangent);
		for (next in nexts)
		{
			var z = vectors[next].getTangent(0);
			while (z <= lastTangent) z += Math.PI * 2;
			//log(function() return "           " + vectors[next] + " // tan = " + z);
		}
		
		nexts.sort(function(a, b)
		{
			var tanA = vectors[a].getTangent(0); while (tanA <= lastTangent) tanA += Math.PI * 2;
			var tanB = vectors[b].getTangent(0); while (tanB <= lastTangent) tanB += Math.PI * 2;
			return Reflect.compare(tanA - lastTangent, tanB - lastTangent);
		});
		
		Debug.assert(lastBestVectorIndex == null || nexts.indexOf(lastBestVectorIndex) >= 0);
		
		var n = lastBestVectorIndex == null ? 0 : nexts.indexOf(lastBestVectorIndex) + 1;
		while (n < nexts.length && excludes[nexts[n]])
		{
			log("exclude(2) " + nexts[n]);
			n++;
		}
		
		return nexts[n];
	}
	
	@:profile
	public static function mergeByCommonEdges(contours:Array<Contour>, counterClockwise:Bool) : Void
	{
		//log(function() return "mergeByCommonEdges vvvvvvvvvvvvvvvvvvvvvvvvvv");
		
		var i = 0; while (i < contours.length)
		{
			var j = i + 1; while (j < contours.length)
			{
				Debug.assert(contours[i].edges.length > 0);
				Debug.assert(contours[j].edges.length > 0);
				
				var commonEdges = Edges.getCommon(contours[i].edges, contours[j].edges);
				if (commonEdges.length > 0)
				{
					var outerEdges = Edges.exclude(Edges.concatUnique(contours[i].edges, contours[j].edges), commonEdges);
					
					if (outerEdges.length > 0)
					{
						var newContours = Contours.fromEdges(outerEdges);
						newContours.sort((x, y) -> x.isNestedTo(y) ? 1 : -1);
						contours[i] = newContours[0];
						if (counterClockwise) contours[i].reverse();
					}
					else
					{
						Debug.assert(false, "Two contours with same edges = " + contours[i]);
					}
					
					contours.splice(j, 1);
					
					i--;
					break;
				}
				j++;
			}
			i++;
		}
		
		//log(function() return "mergeByCommonEdges ^^^^^^^^^^^^^^^^^^^^^^^^^^");
	}
	
	@:profile
	public static function removeNested(contours:Array<Contour>) : Void
	{
		//log(function() return "removeNested vvvvvvvvvvvvvvvvvvvvvvvvvv");
		
		var i = 0; while (i < contours.length)
		{
			var j = 0; while (j < contours.length)
			{
				if (i != j && contours[j].isNestedTo(contours[i]))
				{
					contours.splice(j, 1);
					if (i > j) i--;
				}
				else
				{
					j++;
				}
			}
			i++;
		}
		
		//log(function() return "removeNested ^^^^^^^^^^^^^^^^^^^^^^^^^^");
	}
	
	@:profile
	public static function removeTailEdges(edges:Array<Edge>) : Void
	{
		Edges.removeDublicates(edges);
		Edges.removeDegenerated(edges, true);
		
		while (true)
		{
			var count = edges.length;
			
			var i = 0; while (i < edges.length)
			{
				var edge = edges[i];
				if (Edges.getPointUseCount(edges, edge.x1, edge.y1) == 1 ||
				    Edges.getPointUseCount(edges, edge.x3, edge.y3) == 1)
				{
					edges.splice(i, 1);
				}
				else
				{
					i++;
				}
				
			}
			
			if (edges.length == count) break;
		}
	}
	
	public static function getEdges(contours:Array<Contour>) : Array<Edge>
	{
		var r = [];
		for (c in contours) r = r.concat(c.edges);
		return r;
	}
	
	public static function getTree(contours:Array<Contour>) : Array<Tree<Contour>>
	{
		var parents = contours.filter(function(a) return !contours.exists(function(b) return a != b && a.isNestedTo(b)));
		var allChildren = contours.filter(x -> parents.indexOf(x) < 0);
		
		return parents.map(function(p) return
		{
			parent: p,
			children: getTree(allChildren.filter(x -> x.isNestedTo(p)))
		});
	}
	
	@:profile
	static function getConnections(vectors:Array<Edge>) : Array<Array<Int>>
	{
		var r = [];
		for (i in 0...vectors.length)
		{
			var base = vectors[i];
			var dirs = [];
			for (j in 0...vectors.length)
			{
				if (base.x3 == vectors[j].x1 && base.y3 == vectors[j].y1 && !base.equ(vectors[j]))
				{
					dirs.push(j);
				}
			}
			Debug.assert(dirs.length > 0, function() return "edges = " + vectors.slice(0, vectors.length>>1));
			r.push(dirs);
		}
		return r;
	}
	
	static function isPointUsed(vectors:Array<Edge>, indexes:Array<Int>, x:Float, y:Float) : Bool
	{
		if (vectors[indexes[0]].x1 == x && vectors[indexes[0]].y1 == y) return true;
		for (n in indexes)
		{
			if (vectors[n].x3 == x && vectors[n].y3 == y) return true;
		}
		return false;
	}
	
	@:profile
	static function getSequencesFromEdges(edges:Array<Edge>) : Array<Array<Edge>>
	{
		var r = [];
		
		edges = edges.filter(function(e) return !e.isDegenerated());
		
		var ee = edges.copy();
		while (ee.length > 0)
		{
			var baseEdge = ee.pop();
			
			var equEdge = baseEdge.clone();
			var seqEdges = [ baseEdge ];
			
			var i = 0; while (i < ee.length)
			{
				var edge = ee[i];
				
				if (equEdge.x3 == edge.x1
				 && equEdge.y3 == edge.y1
				 && isSimplePoint(edges, edge.x1, edge.y1)
				) {
					seqEdges.push(edge);
					equEdge.x3 = edge.x3;
					equEdge.y3 = edge.y3;
					ee.splice(i, 1);
					i = 0;
				}
				else
				if (equEdge.x3 == edge.x3
				 && equEdge.y3 == edge.y3
				 && isSimplePoint(edges, edge.x3, edge.y3)
				) {
					seqEdges.push(edge.clone().reverse());
					equEdge.x3 = edge.x1;
					equEdge.y3 = edge.y1;
					ee.splice(i, 1);
					i = 0;
				}
				else
				if (equEdge.x1 == edge.x1
				 && equEdge.y1 == edge.y1
				 && isSimplePoint(edges, edge.x1, edge.y1)
				) {
					seqEdges.unshift(edge.clone().reverse());
					equEdge.x1 = edge.x3;
					equEdge.y1 = edge.y3;
					ee.splice(i, 1);
					i = 0;
				}
				else
				if (equEdge.x1 == edge.x3
				 && equEdge.y1 == edge.y3
				 && isSimplePoint(edges, edge.x3, edge.y3)
				) {
					seqEdges.unshift(edge);
					equEdge.x1 = edge.x1;
					equEdge.y1 = edge.y1;
					ee.splice(i, 1);
					i = 0;
				}
				else
				{
					i++;
				}
			}
			
			r.push(seqEdges);
		}
		
		return r;
	}
	
	static function getSequencesFromVectors(edges:Array<Edge>) : Array<Array<Edge>>
	{
		var r = [];
		
		edges = edges.filter(function(e) return !e.isDegenerated());
		
		var ee = edges.copy();
		while (ee.length > 0)
		{
			var baseEdge = ee.pop();
			
			var equEdge = baseEdge.clone();
			var seqEdges = [ baseEdge ];
			
			var i = 0; while (i < ee.length)
			{
				var edge = ee[i];
				
				if (equEdge.x3 == edge.x1
				 && equEdge.y3 == edge.y1
				 && isSimplePoint(edges, edge.x1, edge.y1)
				) {
					seqEdges.push(edge);
					equEdge.x3 = edge.x3;
					equEdge.y3 = edge.y3;
					ee.splice(i, 1);
					i = 0;
				}
				else
				if (equEdge.x1 == edge.x3
				 && equEdge.y1 == edge.y3
				 && isSimplePoint(edges, edge.x3, edge.y3)
				) {
					seqEdges.unshift(edge);
					equEdge.x1 = edge.x1;
					equEdge.y1 = edge.y1;
					ee.splice(i, 1);
					i = 0;
				}
				else
				{
					i++;
				}
			}
			
			r.push(seqEdges);
		}
		
		return r;
	}
	
	static function isSimplePoint(edges:Array<Edge>, x:Float, y:Float) : Bool
	{
		var c = 0;
		for (e in edges)
		{
			if (e.x1 == x && e.y1 == y) { c++; if (c > 2) return false; }
			if (e.x3 == x && e.y3 == y) { c++; if (c > 2) return false; }
		}
		return true;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}