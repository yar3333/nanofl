package svgimport.gradients;

import htmlparser.HtmlNodeElement;
import nanofl.engine.geom.Bounds;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;

class RadialGradient extends Gradient
{
	public var cx : Float;
	public var cy : Float;
	public var fx : Float;
	public var fy : Float;
	public var r : Float;
	
	public var spreadMethod : String;
	
	public function new(node:HtmlNodeElement, baseType:GradientType) 
	{
		super(node, baseType);
		
		var base : RadialGradient = null;
		if (baseType != null)
		{
			switch (baseType)
			{
				case GradientType.RADIAL(grad): base = grad;
				case _:
			};
		}
		
		cx = node.getFloatValue("cx", base != null ? base.cx : 0.5);
		cy = node.getFloatValue("cy", base != null ? base.cy : 0.5);
		fx = node.getFloatValue("fx", base != null ? base.fx : cx);
		fy = node.getFloatValue("fy", base != null ? base.fy : cy);
		r  = node.getFloatValue("r",  base != null ? base.r  : 0.5);
		
		spreadMethod = node.getAttr("spreadMethod", base != null ? base.spreadMethod : "pad");
	}
	
	public function getAbsoluteParams(bounds:Bounds) : { cx:Float, cy:Float, fx:Float, fy:Float, r:Float }
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
				cx: cx * w + bounds.minX,
				cy: cy * w + bounds.minY,
				fx: fx * w + bounds.minX,
				fy: fy * w + bounds.minY,
				r: r * w
			};
		}
	}	
}