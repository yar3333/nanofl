package flashimport;

import htmlparser.HtmlNodeElement;
import nanofl.ide.DocumentProperties;
using htmlparser.HtmlParserTools;

class DocumentPropertiesParser
{
	public static function load(srcDoc:HtmlNodeElement) : DocumentProperties
	{
		var node = srcDoc.findOne(">DOMDocument");
		return new DocumentProperties
		(
			node.getAttr("width", 550),
			node.getAttr("height", 400),
			node.getAttr("backgroundColor", "#ffffff")
		);
	}
}