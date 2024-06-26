package easeljs.display;

typedef SpriteSheetCompleteEvent = {
	var target : Dynamic;
	var type : String;
};

typedef SpriteSheetGetframeEvent = {
	var frame : Dynamic;
	var index : Int;
};

/**
 * Encapsulates the properties and methods associated with a sprite sheet. A sprite sheet is a series of images (usually
 * animation frames) combined into a larger image (or images). For example, an animation consisting of eight 100x100
 * images could be combined into a single 400x200 sprite sheet (4 frames across by 2 high).
 *
 * The data passed to the SpriteSheet constructor defines:
 * <ol>
 * 	<li> The source image or images to use.</li>
 * 	<li> The positions of individual image frames.</li>
 * 	<li> Sequences of frames that form named animations. Optional.</li>
 * 	<li> The target playback framerate. Optional.</li>
 * </ol>
 * <h3>SpriteSheet Format</h3>
 * SpriteSheets are an object with two required properties (`images` and `frames`), and two optional properties
 * (`framerate` and `animations`). This makes them easy to define in javascript code, or in JSON.
 *
 * <h4>images</h4>
 * An array of source images. Images can be either an HTMlimage
 * instance, or a uri to an image. The former is recommended to control preloading.
 *
 * 	images: [image1, "path/to/image2.png"],
 *
 * <h4>frames</h4>
 * Defines the individual frames. There are two supported formats for frame data:
 * When all of the frames are the same size (in a grid), use an object with `width`, `height`, `regX`, `regY`,
 * and `count` properties.
 *
 * <ul>
 *  <li>`width` & `height` are required and specify the dimensions of the frames</li>
 *  <li>`regX` & `regY` indicate the registration point or "origin" of the frames</li>
 *  <li>`spacing` indicate the spacing between frames</li>
 *  <li>`margin` specify the margin around the image(s)</li>
 *  <li>`count` allows you to specify the total number of frames in the spritesheet; if omitted, this will
 *  be calculated based on the dimensions of the source images and the frames. Frames will be assigned
 *  indexes based on their position in the source images (left to right, top to bottom).</li>
 * </ul>
 *
 *  	frames: {width:64, height:64, count:20, regX: 32, regY:64, spacing:0, margin:0}
 *
 * If the frames are of different sizes, use an array of frame definitions. Each definition is itself an array
 * with 4 required and 3 optional entries, in the order:
 *
 * <ul>
 *  <li>The first four, `x`, `y`, `width`, and `height` are required and define the frame rectangle.</li>
 *  <li>The fifth, `imageIndex`, specifies the index of the source image (defaults to 0)</li>
 *  <li>The last two, `regX` and `regY` specify the registration point of the frame</li>
 * </ul>
 *
 * 	frames: [
 * 		// x, y, width, height, imageIndex*, regX*, regY*
 * 		[64, 0, 96, 64],
 * 		[0, 0, 64, 64, 1, 32, 32]
 * 		// etc.
 * 	]
 *
 * <h4>animations</h4>
 * Optional. An object defining sequences of frames to play as named animations. Each property corresponds to an
 * animation of the same name. Each animation must specify the frames to play, and may
 * also include a relative playback `speed` (ex. 2 would playback at double speed, 0.5 at half), and
 * the name of the `next` animation to sequence to after it completes.
 *
 * There are three formats supported for defining the frames in an animation, which can be mixed and matched as appropriate:
 * <ol>
 * 	<li>for a single frame animation, you can simply specify the frame index
 *
 * 		animations: {
 * 			sit: 7
 * 		}
 *
 * </li>
 * <li>
 *      for an animation of consecutive frames, you can use an array with two required, and two optional entries
 * 		in the order: `start`, `end`, `next`, and `speed`. This will play the frames from start to end inclusive.
 *
 * 		animations: {
 * 			// start, end, next*, speed*
 * 			run: [0, 8],
 * 			jump: [9, 12, "run", 2]
 * 		}
 *
 *  </li>
 *  <li>
 *     for non-consecutive frames, you can use an object with a `frames` property defining an array of frame
 *     indexes to play in order. The object can also specify `next` and `speed` properties.
 *
 * 		animations: {
 * 			walk: {
 * 				frames: [1,2,3,3,2,1]
 * 			},
 * 			shoot: {
 * 				frames: [1,4,5,6],
 * 				next: "walk",
 * 				speed: 0.5
 * 			}
 * 		}
 *
 *  </li>
 * </ol>
 * <strong>Note:</strong> the `speed` property was added in EaselJS 0.7.0. Earlier versions had a `frequency`
 * property instead, which was the inverse of `speed`. For example, a value of "4" would be 1/4 normal speed in
 * earlier versions, but is 4x normal speed in EaselJS 0.7.0+.
 *
 * <h4>framerate</h4>
 * Optional. Indicates the default framerate to play this spritesheet at in frames per second. See
 * {{#crossLink "SpriteSheet/framerate:property"}}{{/crossLink}} for more information.
 *
 * 		framerate: 20
 *
 * Note that the Sprite framerate will only work if the stage update method is provided with the {{#crossLink "Ticker/tick:event"}}{{/crossLink}}
 * event generated by the {{#crossLink "Ticker"}}{{/crossLink}}.
 *
 * 		createjs.Ticker.on("tick", handleTick);
 * 		function handleTick(event) {
 * 			stage.update(event);
 * 		}
 *
 * <h3>Example</h3>
 * To define a simple sprite sheet, with a single image "sprites.jpg" arranged in a regular 50x50 grid with three
 * animations: "stand" showing the first frame, "run" looping frame 1-5 inclusive, and "jump" playing frame 6-8 and
 * sequencing back to run.
 *
 * 		var data = {
 * 			images: ["sprites.jpg"],
 * 			frames: {width:50, height:50},
 * 			animations: {
 * 				stand:0,
 * 				run:[1,5],
 * 				jump:[6,8,"run"]
 * 			}
 * 		};
 * 		var spriteSheet = new createjs.SpriteSheet(data);
 * 		var animation = new createjs.Sprite(spriteSheet, "run");
 *
 * <h3>Generating SpriteSheet Images</h3>
 * Spritesheets can be created manually by combining images in PhotoShop, and specifying the frame size or
 * coordinates manually, however there are a number of tools that facilitate this.
 * <ul>
 *     <li>Exporting SpriteSheets or HTML5 content from Adobe Flash/Animate supports the EaselJS SpriteSheet format.</li>
 *     <li>The popular <a href="https://www.codeandweb.com/texturepacker/easeljs" target="_blank">Texture Packer</a> has
 *     EaselJS support.
 *     <li>SWF animations in Adobe Flash/Animate can be exported to SpriteSheets using <a href="http://createjs.com/zoe" target="_blank">Zo&euml;</a></li>
 * </ul>
 *
 * <h3>Cross Origin Issues</h3>
 * <strong>Warning:</strong> Images loaded cross-origin will throw cross-origin security errors when interacted with
 * using:
 * <ul>
 *     <li>a mouse</li>
 *     <li>methods such as {{#crossLink "Container/getObjectUnderPoint"}}{{/crossLink}}</li>
 *     <li>Filters (see {{#crossLink "Filter"}}{{/crossLink}})</li>
 *     <li>caching (see {{#crossLink "DisplayObject/cache"}}{{/crossLink}})</li>
 * </ul>
 * You can get around this by setting `crossOrigin` property on your images before passing them to EaselJS, or
 * setting the `crossOrigin` property on PreloadJS' LoadQueue or LoadItems.
 *
 * 		var image = new Image();
 * 		img.crossOrigin="Anonymous";
 * 		img.src = "http://server-with-CORS-support.com/path/to/image.jpg";
 *
 * If you pass string paths to SpriteSheets, they will not work cross-origin. The server that stores the image must
 * support cross-origin requests, or this will not work. For more information, check out
 * <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS" target="_blank">CORS overview on MDN</a>.
 */
/**
	
	 * Encapsulates the properties and methods associated with a sprite sheet. A sprite sheet is a series of images (usually
	 * animation frames) combined into a larger image (or images). For example, an animation consisting of eight 100x100
	 * images could be combined into a single 400x200 sprite sheet (4 frames across by 2 high).
	 * 
	 * The data passed to the SpriteSheet constructor defines:
	 * <ol>
	 * 	<li> The source image or images to use.</li>
	 * 	<li> The positions of individual image frames.</li>
	 * 	<li> Sequences of frames that form named animations. Optional.</li>
	 * 	<li> The target playback framerate. Optional.</li>
	 * </ol>
	 * <h3>SpriteSheet Format</h3>
	 * SpriteSheets are an object with two required properties (`images` and `frames`), and two optional properties
	 * (`framerate` and `animations`). This makes them easy to define in javascript code, or in JSON.
	 * 
	 * <h4>images</h4>
	 * An array of source images. Images can be either an HTMlimage
	 * instance, or a uri to an image. The former is recommended to control preloading.
	 * 
	 * 	images: [image1, "path/to/image2.png"],
	 * 
	 * <h4>frames</h4>
	 * Defines the individual frames. There are two supported formats for frame data:
	 * When all of the frames are the same size (in a grid), use an object with `width`, `height`, `regX`, `regY`,
	 * and `count` properties.
	 * 
	 * <ul>
	 *  <li>`width` & `height` are required and specify the dimensions of the frames</li>
	 *  <li>`regX` & `regY` indicate the registration point or "origin" of the frames</li>
	 *  <li>`spacing` indicate the spacing between frames</li>
	 *  <li>`margin` specify the margin around the image(s)</li>
	 *  <li>`count` allows you to specify the total number of frames in the spritesheet; if omitted, this will
	 *  be calculated based on the dimensions of the source images and the frames. Frames will be assigned
	 *  indexes based on their position in the source images (left to right, top to bottom).</li>
	 * </ul>
	 * 
	 *  	frames: {width:64, height:64, count:20, regX: 32, regY:64, spacing:0, margin:0}
	 * 
	 * If the frames are of different sizes, use an array of frame definitions. Each definition is itself an array
	 * with 4 required and 3 optional entries, in the order:
	 * 
	 * <ul>
	 *  <li>The first four, `x`, `y`, `width`, and `height` are required and define the frame rectangle.</li>
	 *  <li>The fifth, `imageIndex`, specifies the index of the source image (defaults to 0)</li>
	 *  <li>The last two, `regX` and `regY` specify the registration point of the frame</li>
	 * </ul>
	 * 
	 * 	frames: [
	 * 		// x, y, width, height, imageIndex*, regX*, regY*
	 * 		[64, 0, 96, 64],
	 * 		[0, 0, 64, 64, 1, 32, 32]
	 * 		// etc.
	 * 	]
	 * 
	 * <h4>animations</h4>
	 * Optional. An object defining sequences of frames to play as named animations. Each property corresponds to an
	 * animation of the same name. Each animation must specify the frames to play, and may
	 * also include a relative playback `speed` (ex. 2 would playback at double speed, 0.5 at half), and
	 * the name of the `next` animation to sequence to after it completes.
	 * 
	 * There are three formats supported for defining the frames in an animation, which can be mixed and matched as appropriate:
	 * <ol>
	 * 	<li>for a single frame animation, you can simply specify the frame index
	 * 
	 * 		animations: {
	 * 			sit: 7
	 * 		}
	 * 
	 * </li>
	 * <li>
	 *      for an animation of consecutive frames, you can use an array with two required, and two optional entries
	 * 		in the order: `start`, `end`, `next`, and `speed`. This will play the frames from start to end inclusive.
	 * 
	 * 		animations: {
	 * 			// start, end, next*, speed*
	 * 			run: [0, 8],
	 * 			jump: [9, 12, "run", 2]
	 * 		}
	 * 
	 *  </li>
	 *  <li>
	 *     for non-consecutive frames, you can use an object with a `frames` property defining an array of frame
	 *     indexes to play in order. The object can also specify `next` and `speed` properties.
	 * 
	 * 		animations: {
	 * 			walk: {
	 * 				frames: [1,2,3,3,2,1]
	 * 			},
	 * 			shoot: {
	 * 				frames: [1,4,5,6],
	 * 				next: "walk",
	 * 				speed: 0.5
	 * 			}
	 * 		}
	 * 
	 *  </li>
	 * </ol>
	 * <strong>Note:</strong> the `speed` property was added in EaselJS 0.7.0. Earlier versions had a `frequency`
	 * property instead, which was the inverse of `speed`. For example, a value of "4" would be 1/4 normal speed in
	 * earlier versions, but is 4x normal speed in EaselJS 0.7.0+.
	 * 
	 * <h4>framerate</h4>
	 * Optional. Indicates the default framerate to play this spritesheet at in frames per second. See
	 * {{#crossLink "SpriteSheet/framerate:property"}}{{/crossLink}} for more information.
	 * 
	 * 		framerate: 20
	 * 
	 * Note that the Sprite framerate will only work if the stage update method is provided with the {{#crossLink "Ticker/tick:event"}}{{/crossLink}}
	 * event generated by the {{#crossLink "Ticker"}}{{/crossLink}}.
	 * 
	 * 		createjs.Ticker.on("tick", handleTick);
	 * 		function handleTick(event) {
	 * 			stage.update(event);
	 * 		}
	 * 
	 * <h3>Example</h3>
	 * To define a simple sprite sheet, with a single image "sprites.jpg" arranged in a regular 50x50 grid with three
	 * animations: "stand" showing the first frame, "run" looping frame 1-5 inclusive, and "jump" playing frame 6-8 and
	 * sequencing back to run.
	 * 
	 * 		var data = {
	 * 			images: ["sprites.jpg"],
	 * 			frames: {width:50, height:50},
	 * 			animations: {
	 * 				stand:0,
	 * 				run:[1,5],
	 * 				jump:[6,8,"run"]
	 * 			}
	 * 		};
	 * 		var spriteSheet = new createjs.SpriteSheet(data);
	 * 		var animation = new createjs.Sprite(spriteSheet, "run");
	 * 
	 * <h3>Generating SpriteSheet Images</h3>
	 * Spritesheets can be created manually by combining images in PhotoShop, and specifying the frame size or
	 * coordinates manually, however there are a number of tools that facilitate this.
	 * <ul>
	 *     <li>Exporting SpriteSheets or HTML5 content from Adobe Flash/Animate supports the EaselJS SpriteSheet format.</li>
	 *     <li>The popular <a href="https://www.codeandweb.com/texturepacker/easeljs" target="_blank">Texture Packer</a> has
	 *     EaselJS support.
	 *     <li>SWF animations in Adobe Flash/Animate can be exported to SpriteSheets using <a href="http://createjs.com/zoe" target="_blank">Zo&euml;</a></li>
	 * </ul>
	 * 
	 * <h3>Cross Origin Issues</h3>
	 * <strong>Warning:</strong> Images loaded cross-origin will throw cross-origin security errors when interacted with
	 * using:
	 * <ul>
	 *     <li>a mouse</li>
	 *     <li>methods such as {{#crossLink "Container/getObjectUnderPoint"}}{{/crossLink}}</li>
	 *     <li>Filters (see {{#crossLink "Filter"}}{{/crossLink}})</li>
	 *     <li>caching (see {{#crossLink "DisplayObject/cache"}}{{/crossLink}})</li>
	 * </ul>
	 * You can get around this by setting `crossOrigin` property on your images before passing them to EaselJS, or
	 * setting the `crossOrigin` property on PreloadJS' LoadQueue or LoadItems.
	 * 
	 * 		var image = new Image();
	 * 		img.crossOrigin="Anonymous";
	 * 		img.src = "http://server-with-CORS-support.com/path/to/image.jpg";
	 * 
	 * If you pass string paths to SpriteSheets, they will not work cross-origin. The server that stores the image must
	 * support cross-origin requests, or this will not work. For more information, check out
	 * <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS" target="_blank">CORS overview on MDN</a>.
	 
**/
@:native('createjs.SpriteSheet') extern class SpriteSheet extends createjs.events.EventDispatcher {
	function new(data:easeljs.display.SpriteSheetData):Void;
	/**
		
			 * Indicates whether all images are finished loading.
			 
	**/
	var complete : Bool;
	/**
		
			 * Specifies the framerate to use by default for Sprite instances using the SpriteSheet. See the Sprite class
			 * {{#crossLink "Sprite/framerate:property"}}{{/crossLink}} for more information.
			 
	**/
	var framerate : Float;
	/**
		
			 * Returns an array of all available animation names available on this sprite sheet as strings.
			 
	**/
	var animations : Array<String>;
	/**
		
			 * Returns the total number of frames in the specified animation, or in the whole sprite
			 * sheet if the animation param is omitted. Returns 0 if the spritesheet relies on calculated frame counts, and
			 * the images have not been fully loaded.
			 
	**/
	function getNumFrames(?animation:String):Int;
	/**
		
			 * Returns an object defining the specified animation. The returned object contains:<UL>
			 * 	<li>frames: an array of the frame ids in the animation</li>
			 * 	<li>speed: the playback speed for this animation</li>
			 * 	<li>name: the name of the animation</li>
			 * 	<li>next: the default animation to play next. If the animation loops, the name and next property will be the
			 * 	same.</li>
			 * </UL>
			 
	**/
	function getAnimation(name:String):Dynamic;
	/**
		
			 * Returns an object specifying the image and source rect of the specified frame. The returned object has:<UL>
			 * 	<li>an image property holding a reference to the image object in which the frame is found</li>
			 * 	<li>a rect property containing a Rectangle instance which defines the boundaries for the frame within that
			 * 	image.</li>
			 * 	<li> A regX and regY property corresponding to the regX/Y values for the frame.
			 * </UL>
			 
	**/
	function getFrame(frameIndex:Float):Dynamic;
	/**
		
			 * Returns a {{#crossLink "Rectangle"}}{{/crossLink}} instance defining the bounds of the specified frame relative
			 * to the origin. For example, a 90 x 70 frame with a regX of 50 and a regY of 40 would return:
			 * 
			 * 	[x=-50, y=-40, width=90, height=70]
			 
	**/
	function getFrameBounds(frameIndex:Float, ?rectangle:easeljs.geom.Rectangle):easeljs.geom.Rectangle;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
	/**
		
			 * SpriteSheet cannot be cloned. A SpriteSheet can be shared by multiple Sprite instances without cloning it.
			 
	**/
	function clone():Void;
}