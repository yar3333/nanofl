package svgimport;

import htmlparser.HtmlNodeElement;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.FilterDef;
import nanofl.engine.geom.Bounds;
import svgimport.segments.DrawSegment;
import svgimport.segments.MoveSegment;
import svgimport.segments.QuadraticSegment;
import svgimport.segments.Segment;
import svgimport.SvgElement;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;
using StringTools;

class SvgFilter
{
	var node : HtmlNodeElement;
	
	public var filterUnits : String;
	
	public var x : Float;
	public var y : Float;
	public var width : Float;
	public var height : Float;
	
	public function new(svg:Svg, node:HtmlNodeElement)
	{
		this.node = node;
		
		var id = node.getAttribute("id");
		if (id != null && id != "" && !svg.filters.exists(id))
		{
			svg.filters.set(id, this);
		}
		
		filterUnits = node.getAttribute("filterUnits");
		
		x = XmlTools.getFloatValue(node, "x", null);
		y = XmlTools.getFloatValue(node, "y", null);
		width = XmlTools.getFloatValue(node, "width", null);
		height = XmlTools.getFloatValue(node, "height", null);
	}
	
	public function export() : Array<FilterDef>
	{
		var r = [];
		for (child in node.children)
		{
			var f = exportChild(child);
			if (f == null) return [];
			r.push(f);
		}
		return r;
	}
	
	function exportChild(node:HtmlNodeElement) : FilterDef
	{
		var name = XmlTools.normalizeTag(node.name);
		
		switch (name)
		{
			case "feGaussianBlur":
				var input = node.getAttr("in", "SourceGraphic");
				if (input != "SourceGraphic")
				{
					trace("Filter '" + name + "': 'in' attribute value different to 'SourceGraphic' is not supported.");
					return null;
				}
				
				var stdDeviation = getFloatParams(node.getAttr("stdDeviation"), [0]);
				
				return new FilterDef
				(
					"GaussianBlurFilterPlugin",
					{
						radius: Std.int((stdDeviation[0] + stdDeviation[stdDeviation.length > 1 ? 1 : 0]) / 2)
					}
				);
				
			case "feColorMatrix":
				trace("Filter '" + name + "' is unsupported.");
				
			case "feOffset":
				trace("Filter '" + name + "' is unsupported.");
				
			case "feMerge":
				trace("Filter '" + name + "' is unsupported.");
				
			case "feBlend":
				trace("Filter '" + name + "' is unsupported.");
				
			case "feComponentTransfer", 
				 "feComposite",
				 "feConvolveMatrix",
				 "feDiffuseLighting",
				 "feDisplacementMap",
				 "feFlood",
				 "feImage",
				 "feMorphology",
				 "feSpecularLighting",
				 "feTile",
				 "feTurbulence",
				 "feDistantLight",
				 "fePointLight",
				 "feSpotLight":
				trace("Filter '" + name + "' is not supported.");
				
			case _:
				trace("Unknow filter '" + name + "'.");
		}
		
		return null;
	}
	
	function getFloatParams(s:String, defValue:Array<Float>) : Array<Float>
	{
		if (s == null) return defValue;
		s = s.trim();
		if (s == "") return defValue;
		return ~/[ \t\r\n,]+/g.split(s).map(XmlTools.toFloat.bind(_, null)).filter(function(f) return f != null);
	}
}