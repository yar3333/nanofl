package nanofl.engine;

extern class ColorTools {
	static function parse(s:String):{ var a : Float; var b : Int; var g : Int; var r : Int; };
	static function joinStringAndAlpha(color:String, ?alpha:Float):String;
	static function stringToNumber(color:String, ?defValue:Int):Int;
	static function rgbaToString(rgba:{ @:optional
	var a : Float; var b : Int; var g : Int; var r : Int; }):String;
	static function rgbaToNumber(rgba:{ @:optional
	var a : Float; var b : Int; var g : Int; var r : Int; }):Int;
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
			
	**/
	static function rgbToHsl(rgb:{ var b : Int; var g : Int; var r : Int; }):{ var h : Float; var l : Float; var s : Float; };
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
			
	**/
	static function hslToRgb(hsl:{ var h : Float; var l : Float; var s : Float; }):{ var b : Int; var g : Int; var r : Int; };
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
			
	**/
	static function rgbToHsv(rgb:{ var b : Int; var g : Int; var r : Int; }):{ var h : Float; var s : Float; var v : Float; };
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
			
	**/
	static function hsvToRgb(hsv:{ var h : Float; var s : Float; var v : Float; }):{ var b : Int; var g : Int; var r : Int; };
	static function tweenRgba(start:{ @:optional
	var a : Float; var b : Int; var g : Int; var r : Int; }, finish:{ @:optional
	var a : Float; var b : Int; var g : Int; var r : Int; }, t:Float):{ @:optional
	var a : Float; var b : Int; var g : Int; var r : Int; };
	static function tweenHsl(start:{ var h : Float; var l : Float; var s : Float; }, finish:{ var h : Float; var l : Float; var s : Float; }, t:Float):{ var h : Float; var l : Float; var s : Float; };
	static function normalize(s:String):String;
	static function getTweened(start:String, k:Float, finish:String):String;
}