package svgimport;

import nanofl.engine.geom.Matrix;

class Transform
{
	public static function load(trans:String) : Matrix
	{
		if (trans == null || trans == "") return new Matrix();
		
		var matrix = new Matrix();
		
		var re = ~/^\s*([a-zA-Z]+)\s*\(([^)]*)\)\s*/;
		while (re.match(trans))
		{
			var params = ~/[ \t\r\n,]+/g.split(re.matched(2)).map(Std.parseFloat);
			
			switch (re.matched(1))
			{
				case "translate":
					if (params.length == 2)
					{
						matrix.appendTransform(params[0], params[1]);
					}
					else
					if (params.length == 1)
					{
						matrix.appendTransform(params[0], 0);
					}
					else
					{
						trace("Transform/translate: invalid params '" + re.matched(2) + "'.");
					}
					
				case "scale":
					if (params.length == 2)
					{
						matrix.appendTransform(0, 0, params[0], params[1]);
					}
					else
					if (params.length == 1)
					{
						matrix.appendTransform(0, 0, params[0], params[0]);
					}
					else
					{
						trace("Transform/scale: invalid params '" + re.matched(2) + "'.");
					}
					
				case "rotate":
					if (params.length == 1)
					{
						matrix.appendTransform(0, 0, 1, 1, params[0]);
					}
					else
					if (params.length == 2)
					{
						matrix.appendTransform( params[1],  0, 1, 1, 0);
						matrix.appendTransform(0, 0, 1, 1, params[0]);
						matrix.appendTransform(-params[1], 0);
					}
					else
					if (params.length == 3)
					{
						matrix.appendTransform( params[1],  params[2], 1, 1, 0);
						matrix.appendTransform(0, 0, 1, 1, params[0]);
						matrix.appendTransform(-params[1], -params[2]);
					}
					else
					{
						trace("Transform/rotate: invalid params '" + re.matched(2) + "'.");
					}
					
				case "matrix":
					if (params.length == 6)
					{
						matrix.append
						(
							params[0],
							params[1],
							params[2],
							params[3],
							params[4],
							params[5]
						);
					}
					
				case _:
					trace("Unknow transform: '" + re.matched(1) + "'.");
			}
			
			trans = re.matchedRight();
		}
		
		return matrix;
	}
}