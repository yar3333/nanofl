package js.html.webgl.extension;

/**
 The `WEBGL_draw_buffers` extension is part of the WebGL API and enables a fragment shader to write to several textures, which is useful for deferred shading, for example.
 
 Documentation [WEBGL_draw_buffers](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_draw_buffers) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_draw_buffers$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_draw_buffers>
 */
/**
	
		The `WEBGL_draw_buffers` extension is part of the WebGL API and enables a fragment shader to write to several textures, which is useful for deferred shading, for example.
	
		Documentation [WEBGL_draw_buffers](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_draw_buffers) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_draw_buffers$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_draw_buffers>
	
**/
@:native("WEBGL_draw_buffers") extern class WEBGLDrawBuffers {
	/**
		
				
				 Defines the draw buffers to which all fragment colors are written. (When using `WebGL2RenderingContext`, this method is available as `WebGL2RenderingContext.drawBuffers()` by default).
				 
			
	**/
	function drawBuffersWEBGL(buffers:Array<Int>):Void;
	/**
		
				A `GLenum` specifying a color buffer.
			
	**/
	static var COLOR_ATTACHMENT0_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT1_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT2_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT3_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT4_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT5_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT6_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT7_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT8_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT9_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT10_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT11_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT12_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT13_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT14_WEBGL(default, never) : Int;
	static var COLOR_ATTACHMENT15_WEBGL(default, never) : Int;
	/**
		
				A `GLenum` returning a draw buffer.
			
	**/
	static var DRAW_BUFFER0_WEBGL(default, never) : Int;
	static var DRAW_BUFFER1_WEBGL(default, never) : Int;
	static var DRAW_BUFFER2_WEBGL(default, never) : Int;
	static var DRAW_BUFFER3_WEBGL(default, never) : Int;
	static var DRAW_BUFFER4_WEBGL(default, never) : Int;
	static var DRAW_BUFFER5_WEBGL(default, never) : Int;
	static var DRAW_BUFFER6_WEBGL(default, never) : Int;
	static var DRAW_BUFFER7_WEBGL(default, never) : Int;
	static var DRAW_BUFFER8_WEBGL(default, never) : Int;
	static var DRAW_BUFFER9_WEBGL(default, never) : Int;
	static var DRAW_BUFFER10_WEBGL(default, never) : Int;
	static var DRAW_BUFFER11_WEBGL(default, never) : Int;
	static var DRAW_BUFFER12_WEBGL(default, never) : Int;
	static var DRAW_BUFFER13_WEBGL(default, never) : Int;
	static var DRAW_BUFFER14_WEBGL(default, never) : Int;
	static var DRAW_BUFFER15_WEBGL(default, never) : Int;
	/**
		
				A `GLint` indicating the maximum number of framebuffer color attachment points.
			
	**/
	static var MAX_COLOR_ATTACHMENTS_WEBGL(default, never) : Int;
	/**
		
				A `GLint` indicating the maximum number of draw buffers.
			
	**/
	static var MAX_DRAW_BUFFERS_WEBGL(default, never) : Int;
}