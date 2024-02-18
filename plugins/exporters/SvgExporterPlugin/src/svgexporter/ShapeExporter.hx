package svgexporter;

import htmlparser.XmlBuilder;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.IFill;
import nanofl.engine.strokes.IStroke;
import svgexporter.ShapeExporter;
using Lambda;

class ShapeExporter
{
	var strokes = new Array<IStroke>();
	var fills = new Array<IFill>();
	var gradients = new Array<Gradient>();

	public function new() {}
	
	public function exportGradients(shape:ShapeElement, xml:XmlBuilder)
	{
		for (edge in shape.edges)
		{
			if (!strokes.exists((x) -> x.equ(edge.stroke)))
			{
				var g = Gradient.fromStroke(edge.stroke);
				if (g != null)
				{
					if (!gradients.exists((x) -> x.equ(g)))
					{
						g.write(gradients.length, xml);
						gradients.push(g);
					}
					strokes.push(edge.stroke);
				}
			}
		}
		
		for (polygon in shape.polygons)
		{
			if (!fills.exists((x) -> x.equ(polygon.fill)))
			{
				var g = Gradient.fromFill(polygon.fill);
				if (g != null)
				{
					if (!gradients.exists((x) -> x.equ(g)))
					{
						g.write(gradients.length, xml);
						gradients.push(g);
					}
					fills.push(polygon.fill);
				}
			}
		}
	}
	
	public function export(idPrefix:String, shape:ShapeElement, xml:XmlBuilder) : Array<String>
	{
		var render = new ShapePathsRender(idPrefix, gradients, xml);
		shape.draw(render, null);
		return render.ids;
	}
}