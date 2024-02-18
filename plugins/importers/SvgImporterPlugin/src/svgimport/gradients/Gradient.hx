package svgimport.gradients;

import htmlparser.HtmlNodeElement;
import nanofl.engine.geom.Matrix;
using htmlparser.HtmlParserTools;

class Gradient
{
	public var gradientUnits : String;
	
	public var colors : Array<String>;
	public var alphas : Array<Float>;
	public var ratios : Array<Float>;
	public var matrix : Matrix;
	
	function new(node:HtmlNodeElement, baseType:GradientType)
	{
		// todo - grad.spread = base.spread
		
		var base : Gradient = null;
		if (baseType != null)
		{
			switch (baseType)
			{
				case GradientType.LINEAR(grad): base = grad;
				case GradientType.RADIAL(grad): base = grad;
			}
		}
		
		gradientUnits = node.hasAttribute("gradientUnits")
			? node.getAttribute("gradientUnits")
			: (base != null ? cast base.gradientUnits : "");
		
		colors = base != null ? cast base.colors.copy() : new Array<String>();
		alphas = base != null ? cast base.alphas.copy() : new Array<Float>();
		ratios = base != null ? cast base.ratios.copy() : new Array<Float>();
		
		for (stop in node.children)
		{
			var styles = XmlTools.getStyles(stop, null);
			colors.push(XmlTools.getColorStyle(stop, "stop-color", styles, "#000000"));
			alphas.push(XmlTools.getFloatStyle(stop, "stop-opacity", styles, 1));
			ratios.push(XmlTools.getFloatStyle(stop, "offset", null, 0));
		}
		
		matrix = Transform.load(node.getAttribute("gradientTransform"));
		if (base != null) matrix.prependMatrix(base.matrix);
	}
	
	public static function load(svg:Svg, node:HtmlNodeElement, ?baseType:GradientType) : GradientType
	{
		switch (XmlTools.normalizeTag(node.name))
		{
			case "linearGradient": return GradientType.LINEAR(new LinearGradient(node, baseType, svg.viewBox != null ? svg.viewBox.width : svg.width));
			case "radialGradient": return GradientType.RADIAL(new RadialGradient(node, baseType));
			case _: throw "Unknow gradient tag '" + node.name + "'.";
		};
	}
}
