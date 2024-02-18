package svgimport;

import htmlparser.HtmlNodeElement;
import svgimport.gradients.GradientType;
import nanofl.engine.Library;
using StringTools;

class Svg extends SvgGroup
{
	public var height(default, null) : Float;
	public var width(default, null) : Float;
	
	public var viewBox : Rectangle;
	
	//public var nodes = new Map<String, HtmlNodeElement>();
	public var elements = new Map<String, SvgElement>();
	public var gradients = new Map<String, GradientType>();
	public var filters = new Map<String, SvgFilter>();
	
	public var usedIDs = new Array<String>();
	
	public function new(xml:HtmlNodeElement)
	{
		var svg = xml.children.length > 0 ? xml.children[0] : null;
		
		if (svg == null || (svg.name != "svg" && svg.name != "svg:svg"))
		{
			throw "Not an SVG file (" + (svg == null ? "null" : svg.name) + ")";
		}
		
		detectSize(svg);
		//fillNodes(svg);
		
		super(this, svg, new Map<String, String>());
	}
	
	function detectSize(svg:HtmlNodeElement)
	{
		width = 400.0;
		height = 400.0;
		
		if (svg.hasAttribute("viewBox"))
		{
			var params = ~/\s+/g.split(svg.getAttribute("viewBox"));
			if (params.length == 4)
			{
				viewBox = new Rectangle
				(
					Std.parseFloat(params[0]),
					Std.parseFloat(params[1]),
					Std.parseFloat(params[2]),
					Std.parseFloat(params[3])
				);
			}
		}
		
		if (svg.hasAttribute("width") && !svg.getAttribute("width").endsWith("%")
		 && svg.hasAttribute("height") && !svg.getAttribute("height").endsWith("%"))
		{
			width = XmlTools.getFloatStyle(svg, "width", null, 400.0);
			height = XmlTools.getFloatStyle(svg, "height", null, 400.0);
		}
		else
		if (viewBox != null)
		{
			width = viewBox.width;
			height = viewBox.height;
		}
	}
	
	//function fillNodes(xml:HtmlNodeElement)
	//{
		//for (node in xml.find("*"))
		//{
			//var id = node.getAttribute("id");
			//if (id != null)
			//{
				//id = id.trim();
				//if (id != "")
				//{
					//nodes.set(id, node);
				//}
			//}
		//}
	//}
}