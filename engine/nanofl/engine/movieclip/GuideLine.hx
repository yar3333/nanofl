package nanofl.engine.movieclip;

import stdlib.Debug;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.Edge;
import nanofl.engine.elements.ShapeElement;
using nanofl.engine.geom.PointTools;
using stdlib.Lambda;

private typedef Params =
{
	var counter: Int;
	var endEdge : Edge;
	
	var bestLen : Float;
	var bestPath : Array<Int>;
	
	var path : Array<Int>;
	var len : Float;
}

class GuideLine
{
    var shape : ShapeElement;

	var vectors : Array<Edge>;
	var connections : Array<Array<Bool>>;
	var used : Array<Bool>;
    
    public function new(?shape:ShapeElement)
    {
		this.shape = shape ?? new ShapeElement();
		
		vectors = cast this.shape.edges.copy();
		for (edge in this.shape.edges) vectors.push(edge.clone().reverse());
		vectors = vectors.filter(function(e) return e.x1 != e.x3 || e.y1 != e.y3);
		
		connections = getConnectionMatrix(vectors);
		
		used = []; for (i in 0...this.shape.edges.length) used.push(false);
    }

	static function getConnectionMatrix(vectors:Array<Edge>) : Array<Array<Bool>>
    {
        var r = [];
        for (a in vectors)
        {
            var line = [];
            for (b in vectors)
            {
                line.push(a.x3 == b.x1 && a.y3 == b.y1);
            }
            r.push(line);
        }
        return r;
    }

    /**
        Assume return array is not empty.
    **/
    public function getPath(startPos:Point, finishPos:Point) : Array<Edge>
    {
        var r = findPath(startPos, finishPos);
        if (r.length == 0) r.push(new Edge(startPos.x, startPos.y, finishPos.x, finishPos.y));
        return r;
    }
        
    function findPath(startPos:Point, finishPos:Point) : Array<Edge>
    {
        if (vectors.length == 0) return [];
        
        var start = shape.getNearestStrokeEdge(startPos);
        var end = shape.getNearestStrokeEdge(finishPos);
        
        log("Guide.findPath " + startPos.toString() + " (" + start.t + ") => " + finishPos.toString() + " (" + end.t + ")" + "\tend.edge = " + end.edge);
        
        var params : Params =
        {
            counter: 0,
            endEdge: end.edge,
            
            bestLen: 1.0e100,
            bestPath: [],
            
            path: [],
            len: 0.0
        };
        
        var startEdgeIndex = shape.edges.findIndex(e -> e.equ(start.edge));
        Debug.assert(startEdgeIndex >= 0, "startEdgeIndex = " + startEdgeIndex);
        
        //log("startEdgeIndex = " + startEdgeIndex);
        
        findPathInner(params, startEdgeIndex);
        findPathInner(params, startEdgeIndex + shape.edges.length);
        
        var path = params.bestPath.map(i -> vectors[i]);
        
        if (path.length > 0)
        {
            var lastI = path.length - 1;
            
            var firstSameDir = path[0].x3 == start.edge.x3 && path[0].y3 == start.edge.y3;
            var lastSameDir = path[lastI].x1 == end.edge.x1 && path[lastI].y1 == end.edge.y1;
            
            path[0] = firstSameDir
                ? path[0].clone().reverse().getPart(1 - start.t).reverse()
                : path[0] = path[0].getPart(start.t);
            
            path[lastI] = lastSameDir
                ? path[lastI].getPart(end.t)
                : path[lastI].clone().reverse().getPart(1 - end.t).reverse();
        }
        
        return path;
    }
    
    function findPathInner(params:Params, nextVectorIndex:Int) : Void
    {
        params.counter++;
        
        //log("findPathInner start " + nextVectorIndex);
        
        var nextVector = vectors[nextVectorIndex];
        var edgesCount = vectors.length >> 1;
        
        params.path.push(nextVectorIndex);
        
        used[nextVectorIndex % edgesCount] = true;
        
        params.len += nextVector.getLength();
        
        if (params.len < params.bestLen)
        {
            if (nextVector.equ(params.endEdge))
            {
                params.bestLen = params.len;
                params.bestPath = params.path.copy();
                //log("FIND OK bestLen = " + params.bestLen + "; bestPath = " + params.bestPath);
            }
            else
            {
                for (i in 0...vectors.length)
                {
                    if (!used[i % edgesCount] && connections[nextVectorIndex][i])
                    {
                        findPathInner(params, i);
                    }
                }
            }
        }
        
        params.len -= nextVector.getLength();
        
        used[nextVectorIndex % edgesCount] = false;
        
        params.path.pop();
        
        //log("findPathInner finish " + nextVectorIndex);
    }
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
