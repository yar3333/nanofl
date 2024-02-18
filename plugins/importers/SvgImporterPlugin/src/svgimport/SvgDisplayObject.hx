package svgimport;

import htmlparser.HtmlNodeElement;
import nanofl.engine.geom.Matrix;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;

class SvgDisplayObject
{
	var svg : Svg;
	
	public var node : HtmlNodeElement;
	
	public var id : String;
	public var matrix : Matrix;
	public var visible : Bool;
	public var clipPathID : String;
	public var filterID : String;
	
	public function new(svg:Svg, node:HtmlNodeElement, baseStyles:Map<String, String>, ?id:String) : Void
	{
		this.svg = svg;
		this.node = node;
		
		this.id = id != null ? id : node.getAttr("id", "");
		matrix = Transform.load(node.getAttribute("transform"));
		
		visible = XmlTools.getStyle(node, "display", baseStyles, null) != "none";
		
		clipPathID = XmlTools.getIdFromUrl(XmlTools.getStyle(node, "clip-path", baseStyles, null));
		
		filterID = XmlTools.getIdFromUrl(XmlTools.getStyle(node, "filter", baseStyles, null));
	}
}