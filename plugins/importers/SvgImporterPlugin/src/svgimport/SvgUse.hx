package svgimport;

import htmlparser.HtmlNodeElement;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;

class SvgUse extends SvgDisplayObject
{
	public var groupID : String;
	public var styles : Map<String, String>;

	public function new(svg:Svg, node:HtmlNodeElement, baseStyles:Map<String, String>)
	{
		super(svg, node, baseStyles, id);
		
		groupID = XmlTools.getIdFromXlink(node);
		
		if (groupID == null)
		{
			trace("Use: 'xlink:href' attribute must be specified.");
			return;
		}
		
		var x = node.getFloatValue("x", 0);
		var y = node.getFloatValue("y", 0);
		if (x != 0 || y != 0) matrix.appendTransform(x, y);
		
		styles = XmlTools.getStyles(node, baseStyles);
	}
}