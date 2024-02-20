package js.three.renderers.webgl;

@:native("THREE.WebGLPrograms") extern class WebGLPrograms {
	function new(renderer:js.three.renderers.WebGLRenderer, cubemaps:js.three.renderers.webgl.WebGLCubeMaps, extensions:js.three.renderers.webgl.WebGLExtensions, capabilities:js.three.renderers.webgl.WebGLCapabilities, bindingStates:js.three.renderers.webgl.WebGLBindingStates, clipping:js.three.renderers.webgl.WebGLClipping):Void;
	var programs : Array<js.three.renderers.webgl.WebGLProgram>;
	function getParameters(material:js.three.materials.Material, lights:js.three.renderers.webgl.WebGLLightsState, shadows:Array<js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>>>, scene:js.three.scenes.Scene, object:js.three.core.Object3D<js.three.core.Object3DEventMap>):js.three.renderers.webgl.WebGLProgramParameters;
	function getProgramCacheKey(parameters:js.three.renderers.webgl.WebGLProgramParameters):String;
	function getUniforms(material:js.three.materials.Material):Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>;
	function acquireProgram(parameters:js.three.renderers.webgl.WebGLProgramParametersWithUniforms, cacheKey:String):js.three.renderers.webgl.WebGLProgram;
	function releaseProgram(program:js.three.renderers.webgl.WebGLProgram):Void;
}