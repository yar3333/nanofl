package flashimport;

import htmlparser.HtmlNodeElement;
import nanofl.engine.geom.PointTools;
import stdlib.Debug;
using htmlparser.HtmlParserTools;
using StringTools;

class EdgeData
{
	public var strokeStyle(default, null) : Int;
	public var fillStyle0(default, null) : Int;
	public var fillStyle1(default, null) : Int;
	public var drawOps(default, null) : Array<DrawOp>;
	
	public function new(edge:HtmlNodeElement) 
	{
		strokeStyle = Std.int(edge.getAttr("strokeStyle", 0));
		fillStyle0 = Std.int(edge.getAttr("fillStyle0", 0));
		fillStyle1 = Std.int(edge.getAttr("fillStyle1", 0));
		
		drawOps = [];
		
		var drawStr : String = edge.getAttr("edges");
		
		if (drawStr == null)
		{
			//trace("WARNING 'edge' element without 'edges' attribute.");
			return;
		}
		
		var reNumber = "(#?-?[0-9A-F]+(?:[.][0-9A-F]+)?)";
		var reXY = new EReg("^" + reNumber + "\\s+" + reNumber + "\\s*", "i");
		var reX1Y1X2Y2 = new EReg("^" + reNumber + "\\s+" + reNumber + "\\s+" + reNumber + "\\s+" + reNumber + "\\s*", "i");
		
		var lastX = 1.0e10;
		var lastY = 1.0e10;
		
		Debug.assert(drawStr.length == 0 || drawStr.ltrim().charAt(0) == "!", "drawStr = " + drawStr);
		
		while (drawStr.length > 0)
		{
			var opCode = drawStr.charAt(0);
			drawStr = drawStr.substr(1);
			
			if (opCode == "!")
			{
				if (reXY.match(drawStr))
				{
					var x = parseNumber(reXY.matched(1));
					var y = parseNumber(reXY.matched(2));
					
					if (x != lastX || y != lastY)
					{
						drawOps.push(DrawOp.move(x, y));
						lastX = x;
						lastY = y;
					}
					
					drawStr = reXY.matchedRight();
				}
				else
				{
					throw "Expected (x, y).";
				}
			}
			else
			if (opCode == "|" || opCode == "/")
			{
				while (reXY.match(drawStr))
				{
					drawOps.push(DrawOp.line(lastX=parseNumber(reXY.matched(1)), lastY=parseNumber(reXY.matched(2))));
					drawStr = reXY.matchedRight();
				}
			}
			else
			if (opCode == "[")
			{
				while (reX1Y1X2Y2.match(drawStr))
				{
					drawOps.push(DrawOp.curve
					(
						parseNumber(reX1Y1X2Y2.matched(1)), parseNumber(reX1Y1X2Y2.matched(2)),
						lastX=parseNumber(reX1Y1X2Y2.matched(3)), lastY=parseNumber(reX1Y1X2Y2.matched(4))
					));
					drawStr = reX1Y1X2Y2.matchedRight();
				}
			}
			else
			if (opCode == "S")
			{
				//var mask = Std.parseInt(drawStr.charAt(0));
				//out.begin("state");
				//if (mask & 0x01 != 0) out.attr("fillStyle0", true);
				//if (mask & 0x02 != 0) out.attr("fillStyle1", true);
				//if (mask & 0x04 != 0) out.attr("strokeStyle", true);
				//out.end();
				drawStr = drawStr.substr(1);
			}
			else
			if (opCode == " " || opCode == "\r" || opCode == "\n")
			{
				drawStr = drawStr.substr(1);
			}
			else
			{
				throw "Unknow edges code = '" + opCode + "' near '" + drawStr + "'.";
			}
		}
	}
	
	function parseNumber(s:String) : Float
	{
		if (s.startsWith("#"))
		{
			s = s.substr(1);
			var n = s.indexOf(".");
			var high = s.substr(0, n);
			var low = s.substr(n + 1).rpad("0", 2);
			
			var r = Std.parseInt("0x" + high + low); 
			
			#if js
			if (r >= 0x80000000) r = -(~r + 1);
			#end
			
			return PointTools.roundGap(r / 5120); // 256*20
		}
		
		return PointTools.roundGap(0.05 * Std.parseFloat(s));
	}
}