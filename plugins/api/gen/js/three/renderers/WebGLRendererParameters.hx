package js.three.renderers;

typedef WebGLRendererParameters = {
	/**
		
			 * default is false.
			 
	**/
	@:optional
	var alpha : Bool;
	/**
		
			 * default is false.
			 
	**/
	@:optional
	var antialias : Bool;
	/**
		
			 * A Canvas where the renderer draws its output.
			 
	**/
	@:optional
	var canvas : haxe.extern.EitherType<js.html.CanvasElement, js.html.OffscreenCanvas>;
	/**
		
			 * A WebGL Rendering Context.
			 * (https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext)
			 * Default is null
			 
	**/
	@:optional
	var context : js.html.webgl.RenderingContext;
	/**
		
			 * default is true.
			 
	**/
	@:optional
	var depth : Bool;
	/**
		
			 * default is false.
			 
	**/
	@:optional
	var failIfMajorPerformanceCaveat : Bool;
	/**
		
			 * default is false.
			 
	**/
	@:optional
	var logarithmicDepthBuffer : Bool;
	/**
		
			 * Can be "high-performance", "low-power" or "default"
			 
	**/
	@:optional
	var powerPreference : String;
	/**
		
			 * shader precision. Can be "highp", "mediump" or "lowp".
			 
	**/
	@:optional
	var precision : String;
	/**
		
			 * default is true.
			 
	**/
	@:optional
	var premultipliedAlpha : Bool;
	/**
		
			 * default is false.
			 
	**/
	@:optional
	var preserveDrawingBuffer : Bool;
	/**
		
			 * default is true.
			 
	**/
	@:optional
	var stencil : Bool;
};