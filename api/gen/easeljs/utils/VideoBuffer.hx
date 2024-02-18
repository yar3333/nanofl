package easeljs.utils;

/**
 * When an HTML video seeks, including when looping, there is an indeterminate period before a new frame is available.
 * This can result in the video blinking or flashing when it is drawn to a canvas. The VideoBuffer class resolves
 * this issue by drawing each frame to an off-screen canvas and preserving the prior frame during a seek.
 *
 * 	var myBuffer = new createjs.VideoBuffer(myVideo);
 * 	var myBitmap = new Bitmap(myBuffer);
 */
/**
	
	 * When an HTML video seeks, including when looping, there is an indeterminate period before a new frame is available.
	 * This can result in the video blinking or flashing when it is drawn to a canvas. The VideoBuffer class resolves
	 * this issue by drawing each frame to an off-screen canvas and preserving the prior frame during a seek.
	 * 
	 * 	var myBuffer = new createjs.VideoBuffer(myVideo);
	 * 	var myBitmap = new Bitmap(myBuffer);
	 
**/
@:native('createjs.VideoBuffer') extern class VideoBuffer {
	function new(video:js.html.VideoElement):Void;
	/**
		
			 * Gets an HTML canvas element showing the current video frame, or the previous frame if in a seek / loop.
			 * Primarily for use by {{#crossLink "Bitmap"}}{{/crossLink}}.
			 
	**/
	function getImage():js.html.CanvasElement;
}