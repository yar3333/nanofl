package js.three.core;

@:native("THREE.RenderTarget") extern class RenderTarget<TTexture:(haxe.extern.EitherType<js.three.textures.Texture, Array<js.three.textures.Texture>>)> extends js.three.core.EventDispatcher<{ var dispose : { }; }> {
	function new(?width:Float, ?height:Float, ?options:js.three.core.RenderTargetOptions):Void;
	var isRenderTarget(default, null) : Bool;
	var width : Float;
	var height : Float;
	var depth : Float;
	var scissor : js.three.math.Vector4;
	/**
		
			 * @default false
			 
	**/
	var scissorTest : Bool;
	var viewport : js.three.math.Vector4;
	var texture : TTexture;
	/**
		
			 * @default true
			 
	**/
	var depthBuffer : Bool;
	/**
		
			 * @default true
			 
	**/
	var stencilBuffer : Bool;
	/**
		
			 * @default null
			 
	**/
	var depthTexture : js.three.textures.DepthTexture;
	/**
		
			 * Defines the count of MSAA samples. Can only be used with WebGL 2. Default is **0**.
			 * @default 0
			 
	**/
	var samples : Float;
	function setSize(width:Float, height:Float, ?depth:Float):Void;
	function clone():js.three.core.RenderTarget<js.three.textures.Texture>;
	function copy(source:js.three.core.RenderTarget<js.three.textures.Texture>):js.three.core.RenderTarget<js.three.textures.Texture>;
	function dispose():Void;
}