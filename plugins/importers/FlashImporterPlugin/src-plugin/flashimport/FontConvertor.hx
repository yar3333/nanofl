package flashimport;

using StringTools;

class FontConvertor
{
	var fonts : Array<String>;
	
	public function new(fonts:Array<String>)
	{
		this.fonts = fonts;
	}
	
	public function convert(font:String) : { face:String, style:String }
	{
		var n = font.lastIndexOf("-");
		
		var face = n >= 0 ? font.substring(0, n) : font;
		face = convertFontFamily(face);
		
		var style = n >= 0 ? removeSuffixes(font.substring(n + 1)).toLowerCase() : "";
		if (style == "bolditalic") style = "bold italic";
		style = style.replace("regular", "");
		style = style.replace("semibold", "bold");
		
		return { face:face, style:style };
	}
	
	function convertFontFamily(s:String)
	{
		for (font in fonts) if (font.replace(" ", "") == s) return font;
		s = removeSuffixes(s);
		for (font in fonts) if (font.replace(" ", "") == s) return font;
		return s;
	}
	
	function removeSuffixes(s:String) : String
	{
		var changed = true;
		while (changed)
		{
			changed = false;
			for (suffix in [ "MT", "PS" ])
			{
				if (s.endsWith(suffix))
				{
					s = s.substring(0, s.length - suffix.length);
					changed = true;
				}
			}
		}
		return s;
	}
}