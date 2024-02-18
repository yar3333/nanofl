package nanofl.ide.textureatlas;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import stdlib.Std;

class TextureAtlases
{
	public static function load(node:HtmlNodeElement) : Map<String, TextureAtlasParams>
	{
		var r = new Map<String, TextureAtlasParams>();
		
		for (node in node.find(">textureAtlases>textureAtlas"))
		{
			var params = new TextureAtlasParams
			(
				Std.parseInt(node.getAttribute("width"), 2048),
				Std.parseInt(node.getAttribute("height"), 2048),
				Std.parseInt(node.getAttribute("padding"), 0)
			);
			r.set(node.getAttribute("name"), params);
		}
		
		return r;
	}
	
	public static function save(textureAtlases:Map<String, TextureAtlasParams>, out:XmlBuilder)
	{
		if (textureAtlases.iterator().hasNext())
		{
			out.begin("textureAtlases");
			for (name in textureAtlases.keys())
			{
				var params = textureAtlases.get(name);
				out.begin("textureAtlas");
					out.attr("name", name);
					out.attr("width", params.width);
					out.attr("height", params.height);
					out.attr("padding", params.padding);
				out.end();
			}
			out.end();
		}
	}
}