package nanofl.engine;

using StringTools;

@:expose
class ColorTools
{
    static var colors = 
	{
		"aliceblue":"#f0f8ff", "antiquewhite":"#faebd7", "aqua":"#00ffff", "aquamarine":"#7fffd4", "azure":"#f0ffff",
		"beige":"#f5f5dc", "bisque":"#ffe4c4", "black":"#000000", "blanchedalmond":"#ffebcd", "blue":"#0000ff",
		"blueviolet":"#8a2be2", "brown":"#a52a2a", "burlywood":"#deb887", "cadetblue":"#5f9ea0", "chartreuse":"#7fff00",
		"chocolate":"#d2691e", "coral":"#ff7f50", "cornflowerblue":"#6495ed", "cornsilk":"#fff8dc", "crimson":"#dc143c",
		"cyan":"#00ffff", "darkblue":"#00008b", "darkcyan":"#008b8b", "darkgoldenrod":"#b8860b", "darkgray":"#a9a9a9",
		"darkgreen":"#006400", "darkkhaki":"#bdb76b", "darkmagenta":"#8b008b", "darkolivegreen":"#556b2f", 
		"darkorange":"#ff8c00", "darkorchid":"#9932cc", "darkred":"#8b0000", "darksalmon":"#e9967a",
		"darkseagreen":"#8fbc8f","darkslateblue":"#483d8b","darkslategray":"#2f4f4f","darkturquoise":"#00ced1",
		"darkviolet":"#9400d3", "deeppink":"#ff1493", "deepskyblue":"#00bfff", "dimgray":"#696969", "dodgerblue":"#1e90ff",
		"firebrick":"#b22222", "floralwhite":"#fffaf0", "forestgreen":"#228b22", "fuchsia":"#ff00ff", "gainsboro":"#dcdcdc",
		"ghostwhite":"#f8f8ff", "gold":"#ffd700", "goldenrod":"#daa520", "gray":"#808080", "grey":"#808080", "green":"#008000",
		"greenyellow":"#adff2f", "honeydew":"#f0fff0", "hotpink":"#ff69b4", "indianred ":"#cd5c5c", "indigo":"#4b0082",
		"ivory":"#fffff0", "khaki":"#f0e68c", "lavender":"#e6e6fa", "lavenderblush":"#fff0f5", "lawngreen":"#7cfc00",
		"lemonchiffon":"#fffacd", "lightblue":"#add8e6", "lightcoral":"#f08080", "lightcyan":"#e0ffff",
		"lightgoldenrodyellow":"#fafad2", "lightgrey":"#d3d3d3", "lightgreen":"#90ee90", "lightpink":"#ffb6c1",
		"lightsalmon":"#ffa07a", "lightseagreen":"#20b2aa", "lightskyblue":"#87cefa", "lightslategray":"#778899",
		"lightsteelblue":"#b0c4de", "lightyellow":"#ffffe0", "lime":"#00ff00", "limegreen":"#32cd32", "linen":"#faf0e6",
		"magenta":"#ff00ff", "maroon":"#800000", "mediumaquamarine":"#66cdaa", "mediumblue":"#0000cd",
		"mediumorchid":"#ba55d3", "mediumpurple":"#9370d8", "mediumseagreen":"#3cb371", "mediumslateblue":"#7b68ee",
		"mediumspringgreen":"#00fa9a", "mediumturquoise":"#48d1cc", "mediumvioletred":"#c71585", "midnightblue":"#191970",
		"mintcream":"#f5fffa", "mistyrose":"#ffe4e1", "moccasin":"#ffe4b5", "navajowhite":"#ffdead", "navy":"#000080",
		"oldlace":"#fdf5e6", "olive":"#808000", "olivedrab":"#6b8e23", "orange":"#ffa500", "orangered":"#ff4500",
		"orchid":"#da70d6", "palegoldenrod":"#eee8aa", "palegreen":"#98fb98", "paleturquoise":"#afeeee",
		"palevioletred":"#d87093", "papayawhip":"#ffefd5", "peachpuff":"#ffdab9", "peru":"#cd853f", "pink":"#ffc0cb",
		"plum":"#dda0dd", "powderblue":"#b0e0e6", "purple":"#800080", "red":"#ff0000", "rosybrown":"#bc8f8f",
		"royalblue":"#4169e1", "saddlebrown":"#8b4513", "salmon":"#fa8072", "sandybrown":"#f4a460",
		"seagreen":"#2e8b57", "seashell":"#fff5ee", "sienna":"#a0522d", "silver":"#c0c0c0", "skyblue":"#87ceeb",
		"slateblue":"#6a5acd", "slategray":"#708090", "snow":"#fffafa", "springgreen":"#00ff7f", "steelblue":"#4682b4",
		"tan":"#d2b48c", "teal":"#008080", "thistle":"#d8bfd8", "tomato":"#ff6347", "turquoise":"#40e0d0",
		"violet":"#ee82ee", "wheat":"#f5deb3", "white":"#ffffff", "whitesmoke":"#f5f5f5", "yellow":"#ffff00", "yellowgreen":"#9acd32",
		"transparent":"rgba(0,0,0,0)"
	};
	
	public static function parse(s:String) : { r:Int, g:Int, b:Int, a:Float }
	{
		log("parse color " + s);
		
		var r = -1;
		var g = -1;
		var b = -1;
		var a = 1.0;
		
		s = s.replace(" ", "");
		
		if (Reflect.hasField(colors, s.toLowerCase()))
		{
			s = Reflect.field(colors, s.toLowerCase());
		}
		
		var reRGB = ~/^rgb\(([0-9]+),([0-9]+),([0-9]+)\)$/i;
		var reRGBA = ~/^rgba\(([0-9]+),([0-9]+),([0-9]+),([0-9.e+-]+)\)$/i;
		
		if (~/^#?[0-9A-F]{6}$/i.match(s))
		{
			if (s.startsWith("#")) s = s.substr(1);
			r = Std.parseInt("0x" + s.substr(0, 2));
			g = Std.parseInt("0x" + s.substr(2, 2));
			b = Std.parseInt("0x" + s.substr(4, 2));
		}
		else
		if (~/^#?[0-9A-F]{3}$/i.match(s))
		{
			if (s.startsWith("#")) s = s.substr(1);
			r = Std.parseInt("0x" + s.substr(0, 1) + s.substr(0, 1));
			g = Std.parseInt("0x" + s.substr(1, 1) + s.substr(1, 1));
			b = Std.parseInt("0x" + s.substr(2, 1) + s.substr(2, 1));
		}
		else
		if (reRGB.match(s))
		{
			r = Std.parseInt(reRGB.matched(1));
			g = Std.parseInt(reRGB.matched(2));
			b = Std.parseInt(reRGB.matched(3));
		}
		else
		if (reRGBA.match(s))
		{
			r = Std.parseInt(reRGBA.matched(1));
			g = Std.parseInt(reRGBA.matched(2));
			b = Std.parseInt(reRGBA.matched(3));
			a = Std.parseFloat(reRGBA.matched(4));
		}
		
		if (r >= 0 && g >= 0 && b >= 0)
		{
			return { r:r, g:g, b:b, a:a };
		}
		
		return null;
	}
	
	public static function joinStringAndAlpha(color:String, ?alpha:Float) : String
	{
		var rgba = parse(color);
		if (rgba != null)
		{
			if (alpha != null) rgba.a = alpha;
			return rgbaToString(rgba);
		}
		return null;
	}
	
	public static function stringToNumber(color:String, ?defValue:Int) : Int
	{
		var rgba = parse(color);
		return rgba != null ? rgbaToNumber(rgba) : defValue;
	}
	
	public static function rgbaToString(rgba:{ r:Int, g:Int, b:Int, ?a:Float }) : String
	{
		if (rgba.a == null || rgba.a == 1.0)
		{
			return "#" + StringTools.hex(rgba.r, 2) + StringTools.hex(rgba.g, 2) + StringTools.hex(rgba.b, 2);
		}
		else
		{
			return "rgba(" + rgba.r + "," + rgba.g + "," + rgba.b + "," + rgba.a + ")";
		}
	}
	
	public static function rgbaToNumber(rgba:{ r:Int, g:Int, b:Int, ?a:Float }) : Int
	{
		if (rgba.a == null || rgba.a == 1.0)
		{
			return (rgba.r << 16) | (rgba.g << 8) | rgba.b;
		}
		else
		{
			return (Math.round(rgba.a * 255) << 24) | (rgba.r << 16) | (rgba.g << 8) | rgba.b;
		}
	}
	
	/**
	* Converts an RGB color value to HSL. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSL_color_space.
	* Assumes r, g, and b are contained in the set [0, 255] and
	* returns h, s, and l in the set [0, 1].
	*
	* @param Number r The red color value
	* @param Number g The green color value
	* @param Number b The blue color value
	* @return Array The HSL representation
	*/
	public static function rgbToHsl(rgb:{ r:Int, g:Int, b:Int }) : { h:Float, s:Float, l:Float }
	{
		var r = rgb.r / 255;
		var g = rgb.g / 255;
		var b = rgb.b / 255;
		 
		var max = Math.max(r, Math.max(g, b));
		var min = Math.min(r, Math.min(g, b));
		var h, s, l = (max + min) / 2;
		 
		if (max == min)
		{
			h = s = 0.0; // achromatic
		}
		else
		{
			var d = max - min;
			s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
			 
			if (max == r)
			{
				h = (g - b) / d + (g < b ? 6 : 0);
			}
			else
			if (max == g)
			{
				h = (b - r) / d + 2;
			}
			else
			{
				h = (r - g) / d + 4;
			}
		 
			h /= 6;
		}
	 
		return { h:h, s:s, l:l };
	}
	
	/**
	* Converts an HSL color value to RGB. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSL_color_space.
	* Assumes h, s, and l are contained in the set [0, 1] and
	* returns r, g, and b in the set [0, 255].
	*
	* @param Number h The hue
	* @param Number s The saturation
	* @param Number l The lightness
	* @return Array The RGB representation
	*/
	public static function hslToRgb(hsl:{ h:Float, s:Float, l:Float }) : { r:Int, g:Int, b:Int }
	{
		var r, g, b;
		 
		if (hsl.s == 0.0)
		{
			r = g = b = hsl.l; // achromatic
		}
		else
		{
			function hue2rgb(p:Float, q:Float, t:Float) : Float
			{
				if (t < 0) t += 1;
				if (t > 1) t -= 1;
				if (t < 1/6) return p + (q - p) * 6 * t;
				if (t < 1/2) return q;
				if (t < 2/3) return p + (q - p) * (2/3 - t) * 6;
				return p;
			}
		 
			var q = hsl.l < 0.5 ? hsl.l * (1 + hsl.s) : hsl.l + hsl.s - hsl.l * hsl.s;
			var p = 2 * hsl.l - q;
			 
			r = hue2rgb(p, q, hsl.h + 1/3);
			g = hue2rgb(p, q, hsl.h);
			b = hue2rgb(p, q, hsl.h - 1/3);
		}
		 
		return { r:Std.int(r*255), g:Std.int(g*255), b:Std.int(b*255) };
	}
	
	/**
	* Converts an RGB color value to HSV. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSV_color_space.
	* Assumes r, g, and b are contained in the set [0, 255] and
	* returns h, s, and v in the set [0, 1].
	*
	* @param Number r The red color value
	* @param Number g The green color value
	* @param Number b The blue color value
	* @return Array The HSV representation
	*/
	public static function rgbToHsv(rgb:{ r:Int, g:Int, b:Int }) : { h:Float, s:Float, v:Float }
	{
		var r = rgb.r / 255;
		var g = rgb.g / 255;
		var b = rgb.b / 255;
 
		var max = Math.max(r, Math.max(g, b));
		var min = Math.min(r, Math.min(g, b));
		var h : Float;
		var s : Float;
		var v = max;
		 
		var d = max - min;
		s = max == 0 ? 0 : d / max;
		 
		if (max == min)
		{
			h = 0; // achromatic
		}
		else
		{
			if (max == r)
			{
				h = (g - b) / d + (g < b ? 6 : 0);
			}
			else
			if (max == g)
			{
				h = (b - r) / d + 2;
				
			}
			else
			{
				h = (r - g) / d + 4;
			}
			
			h /= 6;
		}
	 
		return { h:h, s:s, v:v };
	}
	
	/**
	* Converts an HSV color value to RGB. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSV_color_space.
	* Assumes h, s, and v are contained in the set [0, 1] and
	* returns r, g, and b in the set [0, 255].
	*
	* @param Number h The hue
	* @param Number s The saturation
	* @param Number v The value
	* @return Array The RGB representation
	*/
	public static function hsvToRgb(hsv:{ h:Float, s:Float, v:Float }) : { r:Int, g:Int, b:Int }
	{
		var r : Float;
		var g : Float;
		var b : Float;
		 
		var i = Math.floor(hsv.h * 6);
		var f = hsv.h * 6 - i;
		var p = hsv.v * (1 - hsv.s);
		var q = hsv.v * (1 - f * hsv.s);
		var t = hsv.v * (1 - (1 - f) * hsv.s);
		 
		switch (i % 6)
		{
			case 0: r = hsv.v; g = t; b = p;
			case 1: r = q; g = hsv.v; b = p;
			case 2: r = p; g = hsv.v; b = t;
			case 3: r = p; g = q; b = hsv.v;
			case 4: r = t; g = p; b = hsv.v;
			case _: r = hsv.v; g = p; b = q;
		}
		 
		return { r:Std.int(r*255), g:Std.int(g*255), b:Std.int(b*255) };
	}
	
	public static function tweenRgba(start:{ r:Int, g:Int, b:Int, ?a:Float }, finish:{ r:Int, g:Int, b:Int, ?a:Float }, t:Float) : { r:Int, g:Int, b:Int, ?a:Float }
	{
		var r : { r:Int, g:Int, b:Int, ?a:Float } = cast hslToRgb(tweenHsl(rgbToHsl(start), rgbToHsl(finish), t));
		if (start.a != null || finish.a != null)
		{
			var a1 = start.a != null ? start.a : 1.0;
			var a2 = finish.a != null ? finish.a : 1.0;
			r.a = a1 + (a2 - a1) * t;
		}
		return r;
	}
	
	public static function tweenHsl(start: { h:Float, s:Float, l:Float }, finish: { h:Float, s:Float, l:Float }, t:Float) : { h:Float, s:Float, l:Float }
	{
		// TODO: besause h is angle - need more complex calculation
		return
		{
			h: start.h + (finish.h - start.h) * t,
			s: start.s + (finish.s - start.s) * t,
			l: start.l + (finish.l - start.l) * t
		};
	}
	
	public static function normalize(s:String) : String
	{
		if (s == null) return null;
		if (s == "") return "";
		return rgbaToString(parse(s));
	}
	
	public static function getTweened(start:String, k:Float, finish:String) : String
	{
		var rgbaStart = parse(start);
		var rgbaFinish = parse(finish);
		
		return rgbaToString
		({
			r: rgbaStart.r + Math.round((rgbaFinish.r - rgbaStart.r) * k),
			g: rgbaStart.g + Math.round((rgbaFinish.g - rgbaStart.g) * k),
			b: rgbaStart.b + Math.round((rgbaFinish.b - rgbaStart.b) * k),
			a: rgbaStart.a + (rgbaFinish.a - rgbaStart.a) * k
		});
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
