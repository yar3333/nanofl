package js.three.renderers.webgl;

@:native("THREE.WebGLCapabilities") extern class WebGLCapabilities {
	function new(gl:js.html.webgl.RenderingContext, extensions:Dynamic, parameters:js.three.renderers.webgl.WebGLCapabilitiesParameters):Void;
	var isWebGL2(default, null) : Bool;
	var drawBuffers(default, null) : Bool;
	var precision : String;
	var logarithmicDepthBuffer : Bool;
	var maxTextures : Float;
	var maxVertexTextures : Float;
	var maxTextureSize : Float;
	var maxCubemapSize : Float;
	var maxAttributes : Float;
	var maxVertexUniforms : Float;
	var maxVaryings : Float;
	var maxFragmentUniforms : Float;
	var vertexTextures : Bool;
	var floatFragmentTextures : Bool;
	var floatVertexTextures : Bool;
	var maxSamples : Float;
	function getMaxAnisotropy():Int;
	function getMaxPrecision(precision:String):String;
}