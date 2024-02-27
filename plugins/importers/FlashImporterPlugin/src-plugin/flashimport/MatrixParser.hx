package flashimport;

import htmlparser.HtmlNodeElement;
import nanofl.engine.geom.Matrix;
using htmlparser.HtmlParserTools;

class MatrixParser
{
	public static function load(?node:HtmlNodeElement, divider=1.0, dx=0.0, dy=0.0) : Matrix
	{
		if (node != null)
		{
			return new Matrix
			(
				node.getAttr("a", 1.0) / divider,
				node.getAttr("b", 0.0) / divider,
				node.getAttr("c", 0.0) / divider,
				node.getAttr("d", 1.0) / divider,
				node.getAttr("tx", 0.0) + dx,
				node.getAttr("ty", 0.0) + dy
			);
		}
		return new Matrix();
	}
}