package svgimport.gradients;

import nanofl.engine.geom.PointTools;
import htmlparser.HtmlNodeElement;
import nanofl.engine.geom.Bounds;
import nanofl.engine.geom.StraightLine;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;

class LinearGradient extends Gradient
{
	public var x1 : Float;
	public var y1 : Float;
	public var x2 : Float;
	public var y2 : Float;
	
	public var spreadMethod : String;
	
	public function new(node:HtmlNodeElement, baseType:GradientType, svgWidth:Float) 
	{
		super(node, baseType);
		
		var base : LinearGradient = null;
		if (baseType != null)
		{
			switch (baseType)
			{
				case GradientType.LINEAR(grad): base = grad;
				case _:
			};
		}
		
		x1 = node.getFloatValue("x1", base != null ? base.x1 : null);
		y1 = node.getFloatValue("y1", base != null ? base.y1 : null);
		x2 = node.getFloatValue("x2", base != null ? base.x2 : null);
		y2 = node.getFloatValue("y2", base != null ? base.y2 : null);
		
		if (gradientUnits == "userSpaceOnUse")
		{
			if (x1 == null) x1 = 0;
			if (y1 == null) y1 = 0;
			if (x2 == null) x2 = svgWidth;
			if (y2 == null) y2 = 0;
		}
		else
		{
			if (x1 == null && y1 == null && x2 == null && y2 == null)
			{
				x1 = 0;
				y1 = 0;
				x2 = 1;
				y2 = 0;
			}
			else
			{
				if (x1 == null) x1 = 0;
				if (y1 == null) y1 = 0;
				if (x2 == null) x2 = 0;
				if (y2 == null) y2 = 0;
			}
		}
		
		spreadMethod = node.getAttr("spreadMethod", base != null ? base.spreadMethod : "pad");
	}
	
	public function getAbsoluteParams(bounds:Bounds) : { x1:Float, y1:Float, x2:Float, y2:Float }
	{
		if (gradientUnits == "userSpaceOnUse")
		{
			return this;
		}
		else
		{
			var w = bounds.maxX - bounds.minX;
			
			return
			{
				x1: x1 * w + bounds.minX,
				y1: y1 * w + bounds.minY,
				x2: x2 * w + bounds.minX,
				y2: y2 * w + bounds.minY
			};
		}
	}
}