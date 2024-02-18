package nanofl.engine.movieclip;

class Guide
{
	var guideLine : GuideLine;
	
	public function new(?guideLine:GuideLine)
	{
		this.guideLine = guideLine ?? new GuideLine();
	}
	
	public function get(startProps:{ x:Float, y:Float, rotation:Float }, finishProps:{ x:Float, y:Float, rotation:Float }, orientToPath:Bool, t:Float) : { x:Float, y:Float, rotation:Float }
	{
		log("Guide.getPos: " + startProps.x + ", " + startProps.y + " => " + finishProps.x + ", " + finishProps.y + "; t = " + t);
		
		var path = guideLine.getPath(startProps, finishProps);
		log("path = " + path.join("; "));
		
		var lens = path.map(function(e) return e.getLength());
		
		var sumLen = 0.0; for (len in lens) sumLen += len;
		
		if (sumLen == 0.0) return { x:path[0].x1, y:path[0].y1, rotation:startProps.rotation };
		
		var lenPos = sumLen * t;
		//log("t = " + t + "; sumLen = " + sumLen + "; lenPos = " + lenPos);
		
		var curLen = 0.0;
		for (i in 0...path.length)
		{
			if (lens[i] == 0) continue;
			
			curLen += lens[i];
			//log("curLen = " + curLen);
			if (curLen >= lenPos)
			{
				var dLen = lenPos - (curLen - lens[i]);
				var subT = dLen / lens[i];
				//log("lens[i] = " + lens[i] + "; dLen = " + dLen + "; subT = " + subT);
				
				var point = path[i].getPoint(path[i].getMonotoneT(subT));
				
				var rotation : Float;
				if (!orientToPath)
				{
					rotation = startProps.rotation + (finishProps.rotation - startProps.rotation) * t;
				}
				else
				{
					var angleT = path[i].getTangent(subT) * 180 / Math.PI;
					var angleS = path[0].getTangent(0) * 180 / Math.PI;
					var angleF = path[path.length - 1].getTangent(1) * 180 / Math.PI;
					
					rotation = startProps.rotation + (angleT - angleS) + ((finishProps.rotation - angleF) - (startProps.rotation - angleS)) * t;
				}
				
				return { x:point.x, y:point.y, rotation:rotation };
			}
		}
		
		return Reflect.copy(finishProps);
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}