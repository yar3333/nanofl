package js.three.renderers.webgl;

@:native("THREE.WebGLProgram") extern class WebGLProgram {
	function new(renderer:js.three.renderers.WebGLRenderer, cacheKey:String, parameters:Dynamic):Void;
	var name : String;
	var id : Int;
	var cacheKey : String;
	/**
		
			 * @default 1
			 
	**/
	var usedTimes : Float;
	var program : Dynamic;
	var vertexShader : js.html.webgl.Shader;
	var fragmentShader : js.html.webgl.Shader;
	/**
		
			 * @deprecated Use {@link WebGLProgram#getUniforms getUniforms()} instead.
			 
	**/
	var uniforms : Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLProgram#getAttributes getAttributes()} instead.
			 
	**/
	var attributes : Dynamic;
	function getUniforms():js.three.renderers.webgl.WebGLUniforms;
	function getAttributes():Dynamic;
	function destroy():Void;
}