package easeljs.display;

/**
 * Display one or more lines of dynamic text (not user editable) in the display list. Line wrapping support (using the
 * lineWidth) is very basic, wrapping on spaces and tabs only. Note that as an alternative to Text, you can position HTML
 * text above or below the canvas relative to items in the display list using the {{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}}
 * method, or using {{#crossLink "DOMElement"}}{{/crossLink}}.
 *
 * <b>Please note that Text does not support HTML text, and can only display one font style at a time.</b> To use
 * multiple font styles, you will need to create multiple text instances, and position them manually.
 *
 * <h4>Example</h4>
 *
 *      var text = new createjs.Text("Hello World", "20px Arial", "#ff7700");
 *      text.x = 100;
 *      text.textBaseline = "alphabetic";
 *
 * CreateJS Text supports web fonts (the same rules as Canvas). The font must be loaded and supported by the browser
 * before it can be displayed.
 *
 * <strong>Note:</strong> Text can be expensive to generate, so cache instances where possible. Be aware that not all
 * browsers will render Text exactly the same.
 */
/**
	
	 * Display one or more lines of dynamic text (not user editable) in the display list. Line wrapping support (using the
	 * lineWidth) is very basic, wrapping on spaces and tabs only. Note that as an alternative to Text, you can position HTML
	 * text above or below the canvas relative to items in the display list using the {{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}}
	 * method, or using {{#crossLink "DOMElement"}}{{/crossLink}}.
	 * 
	 * <b>Please note that Text does not support HTML text, and can only display one font style at a time.</b> To use
	 * multiple font styles, you will need to create multiple text instances, and position them manually.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var text = new createjs.Text("Hello World", "20px Arial", "#ff7700");
	 *      text.x = 100;
	 *      text.textBaseline = "alphabetic";
	 * 
	 * CreateJS Text supports web fonts (the same rules as Canvas). The font must be loaded and supported by the browser
	 * before it can be displayed.
	 * 
	 * <strong>Note:</strong> Text can be expensive to generate, so cache instances where possible. Be aware that not all
	 * browsers will render Text exactly the same.
	 
**/
@:native('createjs.Text') extern class Text extends easeljs.display.DisplayObject {
	function new(?text:String, ?font:String, ?color:String):Void;
	/**
		
			 * The text to display.
			 
	**/
	var text : String;
	/**
		
			 * The font style to use. Any valid value for the CSS font attribute is acceptable (ex. "bold 36px Arial").
			 
	**/
	var font : String;
	/**
		
			 * The color to draw the text in. Any valid value for the CSS color attribute is acceptable (ex. "#F00"). Default is "#000".
			 * It will also accept valid canvas fillStyle values.
			 
	**/
	var color : String;
	/**
		
			 * The horizontal text alignment. Any of "start", "end", "left", "right", and "center". For detailed
			 * information view the
			 * <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#text-styles">
			 * whatwg spec</a>. Default is "left".
			 
	**/
	var textAlign : String;
	/**
		
			 * The vertical alignment point on the font. Any of "top", "hanging", "middle", "alphabetic", "ideographic", or
			 * "bottom". For detailed information view the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#text-styles">
			 * whatwg spec</a>. Default is "top".
			 
	**/
	var textBaseline : String;
	/**
		
			 * The maximum width to draw the text. If maxWidth is specified (not null), the text will be condensed or
			 * shrunk to make it fit in this width. For detailed information view the
			 * <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#text-styles">
			 * whatwg spec</a>.
			 
	**/
	var maxWidth : Float;
	/**
		
			 * If greater than 0, the text will be drawn as a stroke (outline) of the specified width.
			 
	**/
	var outline : Float;
	/**
		
			 * Indicates the line height (vertical distance between baselines) for multi-line text. If null or 0,
			 * the value of getMeasuredLineHeight is used.
			 
	**/
	var lineHeight : Float;
	/**
		
			 * Indicates the maximum width for a line of text before it is wrapped to multiple lines. If null,
			 * the text will not be wrapped.
			 
	**/
	var lineWidth : Float;
	/**
		
			 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
			 * This does not account for whether it would be visible within the boundaries of the stage.
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function isVisible():Bool;
	/**
		
			 * Draws the Text into the specified context ignoring its visible, alpha, shadow, and transform.
			 * Returns true if the draw was handled (useful for overriding functionality).
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	/**
		
			 * Returns the measured, untransformed width of the text without wrapping. Use getBounds for a more robust value.
			 
	**/
	function getMeasuredWidth():Float;
	/**
		
			 * Returns an approximate line height of the text, ignoring the lineHeight property. This is based on the measured
			 * width of a "M" character multiplied by 1.2, which provides an approximate line height for most fonts.
			 
	**/
	function getMeasuredLineHeight():Float;
	/**
		
			 * Returns the approximate height of multi-line text by multiplying the number of lines against either the
			 * <code>lineHeight</code> (if specified) or {{#crossLink "Text/getMeasuredLineHeight"}}{{/crossLink}}. Note that
			 * this operation requires the text flowing logic to run, which has an associated CPU cost.
			 
	**/
	function getMeasuredHeight():Float;
	/**
		
			 * Returns an object with width, height, and lines properties. The width and height are the visual width and height
			 * of the drawn text. The lines property contains an array of strings, one for
			 * each line of text that will be drawn, accounting for line breaks and wrapping. These strings have trailing
			 * whitespace removed.
			 
	**/
	function getMetrics():Dynamic;
	/**
		
			 * Returns a clone of the Text instance.
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}