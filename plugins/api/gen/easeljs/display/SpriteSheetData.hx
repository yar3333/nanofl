package easeljs.display;

/**
 https://createjs.com/docs/easeljs/classes/SpriteSheet.html
 */
/**
	
	    https://createjs.com/docs/easeljs/classes/SpriteSheet.html
	
**/
typedef SpriteSheetData = {
	@:optional
	var animations : Dynamic<haxe.extern.EitherType<Int, Array<Dynamic>>>;
	@:optional
	var framerate : Float;
	/**
		
		        For each frame: [ x, y, width, height, imageIndex, regX, regY ]
		    
	**/
	var frames : Array<Array<Float>>;
	/**
		
		        Strings is URLs to images.
		    
	**/
	var images : Array<haxe.extern.EitherType<js.html.ImageElement, String>>;
};