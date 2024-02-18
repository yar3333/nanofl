package svgimport;

import htmlparser.HtmlNodeElement;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.geom.Bounds;
import svgimport.segments.DrawSegment;
import svgimport.segments.MoveSegment;
import svgimport.segments.QuadraticSegment;
import svgimport.segments.Segment;
import svgimport.SvgElement;
using htmlparser.HtmlParserTools;
using svgimport.XmlTools;

class SvgPath extends SvgDisplayObject
{
	private static var SIN45 = 0.70710678118654752440084436210485;
	private static var TAN22 = 0.4142135623730950488016887242097;
	
	public var alpha : Float;
	
	public var fill : FillType;
	public var fillAlpha : Float;
	public var fillRuleEvenOdd : Bool;
	
	public var stroke : StrokeType;
	public var strokeAlpha : Float;
	public var strokeWidth : Float;
	public var strokeCaps : String;
	public var strokeJoints : String;
	public var strokeMiterLimit : Float;

	public var segments : Array<Segment>;
	
	public function new(svg:Svg, node:HtmlNodeElement, baseStyles:Map<String, String>, ?id:String) : Void
	{
		super(svg, node, baseStyles, id);
		
		if (this.id != "") svg.elements.set(this.id, SvgElement.DisplayPath(this));
		
		var styles = XmlTools.getStyles(node, baseStyles);
		
		alpha = XmlTools.getFloatStyle(node, "opacity", styles, 1.0);
		
		fill = XmlTools.getFillStyle(node, "fill", styles, svg.gradients);
		fillAlpha = XmlTools.getFloatStyle(node, "fill-opacity", styles, 1.0);
		fillRuleEvenOdd = XmlTools.getStyle(node, "fill-rule", styles, "nonzero") == "evenodd";
		
		stroke = XmlTools.getStrokeStyle(node, "stroke", styles, svg.gradients);
		strokeAlpha = XmlTools.getFloatStyle(node, "stroke-opacity", styles, 1.0);
		strokeWidth = XmlTools.getFloatStyle(node, "stroke-width", styles, 1.0);
		strokeCaps = XmlTools.getStyle(node, "stroke-linecap", styles, "butt");
		strokeJoints = XmlTools.getStyle(node, "stroke-linejoin", styles, "miter");
		strokeMiterLimit = XmlTools.getFloatStyle(node, "stroke-miterlimit", styles, 4.0);
		
		segments = [];
		
		switch (XmlTools.normalizeTag(node.name))
		{
			case "rect":
				var x = node.getFloatValue("x", 0);
				var y = node.getFloatValue("y", 0);
				var w = node.getFloatValue("width", 0);
				var h = node.getFloatValue("height", 0);
				var rx = node.getFloatValue("rx", 0);
				var ry = node.getFloatValue("ry", rx);
				
				if (rx == 0 || ry == 0)
				{
					segments.push(new MoveSegment(x, y));
					segments.push(new DrawSegment(x + w, y));
					segments.push(new DrawSegment(x + w, y + h));
					segments.push(new DrawSegment(x, y + h));
					segments.push(new DrawSegment(x, y));
				}
				else
				{
					segments.push(new MoveSegment(x + rx, y));
					segments.push(new DrawSegment(x + w - rx, y));
					segments.push(new QuadraticSegment(x + w, y, x + w, y + ry));
					segments.push(new DrawSegment(x + w, y + h - ry));
					segments.push(new QuadraticSegment(x + w, y + h, x + w - rx, y + h));
					segments.push(new DrawSegment(x + rx, y + h));
					segments.push(new QuadraticSegment(x, y + h, x, y + h - ry));
					segments.push(new DrawSegment(x, y + ry));
					segments.push(new QuadraticSegment(x, y, x + rx, y));
				}
				
			case "ellipse", "circle":
				var x = node.getFloatValue("cx", 0);
				var y = node.getFloatValue("cy", 0);
				var r = node.getFloatValue("r", 0);
				var w = node.getFloatValue("rx", r);
				var w_ = w * SIN45;
				var cw_ = w * TAN22;
				var h = node.getFloatValue("ry", r);
				var h_ = h * SIN45;
				var ch_ = h * TAN22;
				
				segments.push(new MoveSegment(x + w, y));
				segments.push(new QuadraticSegment(x + w, y + ch_, x + w_, y + h_));
				segments.push(new QuadraticSegment(x + cw_, y + h, x, y + h));
				segments.push(new QuadraticSegment(x - cw_, y + h, x - w_, y + h_));
				segments.push(new QuadraticSegment(x - w, y + ch_, x - w, y));
				segments.push(new QuadraticSegment(x - w, y - ch_, x - w_, y - h_));
				segments.push(new QuadraticSegment(x - cw_, y - h, x, y - h));
				segments.push(new QuadraticSegment(x + cw_, y - h, x + w_, y - h_));
				segments.push(new QuadraticSegment(x + w, y - ch_, x + w, y));
				
				strokeCaps = "round";
				strokeJoints = "round";
				
			case "polyline":
				segments = segments.concat(SegmentsParser.run("M" + node.getAttribute("points")));
				
			case "polygon":
				segments = segments.concat(SegmentsParser.run("M" + node.getAttribute("points") + "z"));
				
			case "path":
				segments = segments.concat(SegmentsParser.run(node.getAttribute("d")));
		}
	}
	
	public function toElement() : { shape:ShapeElement, bounds:Bounds }
	{
		if (segments.length == 0) return null;
		
		var convertor = new SvgPathToShapeConvertor();
		
		if (fill != null && fill != FillType.FillNone)
		{
			convertor.beginFill(this);
			for (segment in segments) segment.export(convertor);
			convertor.endFill();
		}
		
		if (stroke != null && stroke != StrokeType.StrokeNone)
		{
			convertor.beginStroke(this);
			for (segment in segments) segment.export(convertor);
			convertor.endStroke();
		}
		
		var shape = convertor.convert();
		
		shape.applyStrokeAlpha(alpha * strokeAlpha);
		shape.applyFillAlpha(alpha * fillAlpha);
		
		if (shape.isEmpty()) return null;
		
		return { shape:shape, bounds:convertor.getBounds() };
	}
}
