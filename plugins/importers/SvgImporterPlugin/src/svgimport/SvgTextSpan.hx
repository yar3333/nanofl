package svgimport;

import htmlparser.HtmlNodeElement;
import svgimport.gradients.GradientType;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;

class SvgTextSpan extends SvgTextStyle
{
	public var text : String;
   
	public function new(node:HtmlNodeElement, baseStyles:Map<String, String>, gradients:Map<String, GradientType>)
	{
		super(node, baseStyles, gradients);
		text = node.innerText;
	}
}
