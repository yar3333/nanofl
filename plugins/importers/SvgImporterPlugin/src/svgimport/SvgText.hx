package svgimport;

import htmlparser.HtmlNodeElement;
import htmlparser.HtmlNodeText;
import nanofl.engine.geom.Matrix;
import svgimport.gradients.GradientType;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;

class SvgText extends SvgTextStyle
{
	public var name : String;
	public var matrix : Matrix;
	public var textAnchor : String;
	public var spans = new Array<SvgTextSpan>();
   
	public function new(node:HtmlNodeElement, baseStyles:Map<String, String>, gradients:Map<String, GradientType>)
	{
		super(node, baseStyles, gradients);
		
		matrix = Transform.load(node.getAttribute("transform"));
		
		var styles = XmlTools.getStyles(node, baseStyles);
		
		name = node.getAttr("id", "");
		
		var x = node.getFloatValue("x", 0);
		var y = node.getFloatValue("y", 0);
		if (x != 0 || y != 0) matrix.appendTransform(x, y);
		
		textAnchor = XmlTools.getStyle(node, "text-anchor", styles, "left");
		
		loadFromChildrenNodes(node, styles, gradients);
	}
	
	function loadFromChildrenNodes(base:HtmlNodeElement, styles:Map<String, String>, gradients:Map<String, GradientType>)
	{
		for (node in base.nodes)
		{
			if (Std.is(node, HtmlNodeElement))
			{
				if ((cast node:HtmlNodeElement).name == "tspan")
				{
					spans.push(new SvgTextSpan((cast node:HtmlNodeElement), styles, gradients));
				}
				else
				{
					loadFromChildrenNodes((cast node:HtmlNodeElement), styles, gradients);
				}
			}
			else
			if (Std.is(node, HtmlNodeText))
			{
				var span = new HtmlNodeElement("tspan", []);
				span.addChild(new HtmlNodeText((cast node:HtmlNodeText).text));
				spans.push(new SvgTextSpan(span, styles, gradients));
			}
		}
	}
}
