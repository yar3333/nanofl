package preloadjs.loaders;

/**
 * A loader that handles font files, CSS definitions, and CSS paths. FontLoader doesn't actually preload fonts
 * themselves, but rather generates CSS definitions, and then tests the size changes on an HTML5 Canvas element.
 *
 * Note that FontLoader does not support tag-based loading due to the requirement that CSS be read to determine the
 * font definitions to test for.
 */
/**
	
	 * A loader that handles font files, CSS definitions, and CSS paths. FontLoader doesn't actually preload fonts
	 * themselves, but rather generates CSS definitions, and then tests the size changes on an HTML5 Canvas element.
	 * 
	 * Note that FontLoader does not support tag-based loading due to the requirement that CSS be read to determine the
	 * font definitions to test for.
	 
**/
@:native('createjs.FontLoader') extern class FontLoader extends preloadjs.loaders.AbstractLoader {
	function new(loadItem:Dynamic):Void;
	/**
		
			 * A regular expression that pulls out possible style values from the font name.
			 * <ul>
			 *     <li>This includes font names that include thin, normal, book, regular, medium, black, and heavy (such as
			 *     "Arial Black")</li>
			 *     <li>Weight modifiers including extra, ultra, semi, demi, light, and bold (such as "WorkSans SemiBold")</li>
			 * </ul>
			 * 
			 * Weight descriptions map to font weight values by default using the following (from
			 * http://www.w3.org/TR/css3-fonts/#font-weight-numeric-values):
			 * <ul>
			 *     <li>100 - Thin</li>
			 * 	   <li>200 - Extra Light, Ultra Light</li>
			 *     <li>300 - Light, Semi Light, Demi Light</li>
			 *     <li>400 - Normal, Book, Regular</li>
			 *     <li>500 - Medium</li>
			 *     <li>600 - Semi Bold, Demi Bold</li>
			 *     <li>700 - Bold</li>
			 *     <li>800 - Extra Bold, Ultra Bold</li>
			 *     <li>900 - Black, Heavy</li>
			 * </ul>
			 
	**/
	static var WEIGHT_REGEX : Dynamic;
	/**
		
			 * A regular expression that pulls out possible style values from the font name. These include "italic"
			 * and "oblique".
			 
	**/
	static var STYLE_REGEX : Dynamic;
	/**
		
			 * A lookup of font types for generating a CSS definition. For example, TTF fonts requires a "truetype" type.
			 
	**/
	static var FONT_FORMAT : Dynamic;
	/**
		
			 * A lookup of font weights based on a name. These values are from http://www.w3.org/TR/css3-fonts/#font-weight-numeric-values.
			 
	**/
	static var FONT_WEIGHT : Dynamic;
	/**
		
			 * The frequency in milliseconds to check for loaded fonts.
			 
	**/
	static var WATCH_DURATION : Float;
	/**
		
			 * Determines if the loader can load a specific item. This loader can only load items that are of type
			 * {{#crossLink "Types/FONT:property"}}{{/crossLink}}.
			 
	**/
	static function canLoadItem(item:Dynamic):Bool;
}