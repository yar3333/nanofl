package nanofl.engine;

class DrawTools
{
	public static function drawDashedLine(g:ShapeRender, x1:Float, y1:Float, x2:Float, y2:Float, color1:String, ?color2:String, dashLen=2.0) : ShapeRender
	{
		var dX = x2 - x1;
		var dY = y2 - y1;
		var dashes = Math.floor(Math.sqrt(dX * dX + dY * dY) / dashLen);
		var dashX = dX / dashes;
		var dashY = dY / dashes;
		
		g.beginStroke(color1);
		var x = x1;
		var y = y1;
		g.moveTo(x, y);
		var q = 0;
		while (q++ < dashes)
		{
			x += dashX;
			y += dashY;
			if (q % 2 == 0) g.moveTo(x, y);
			else            g.lineTo(x, y);
		}
		if (q % 2 == 0) g.moveTo(x2, y2);
		else            g.lineTo(x2, y2);
		g.endStroke();
		
		if (color2 != null)
		{
			g.beginStroke(color2);
			x = x1 + dashX;
			y = y1 + dashY;
			g.moveTo(x, y);
			q = 1;
			while (q++ < dashes)
			{
				x += dashX;
				y += dashY;
				if (q % 2 == 1) g.moveTo(x, y);
				else            g.lineTo(x, y);
			}
			if (q % 2 == 1) g.moveTo(x2, y2);
			else            g.lineTo(x2, y2);
			g.endStroke();
		}
		
		return g;
	}
	
	public static function drawDashedRect(g:ShapeRender, x1:Float, y1:Float, x2:Float, y2:Float, color1:String, ?color2:String, dashLen = 2.0) : ShapeRender
	{
		drawDashedLine(g, x1, y1, x2, y1, color1, color2, dashLen);
		drawDashedLine(g, x2, y1, x2, y2, color1, color2, dashLen);
		drawDashedLine(g, x2, y2, x1, y2, color1, color2, dashLen);
		drawDashedLine(g, x1, y2, x1, y1, color1, color2, dashLen);
		return g;
	}
}