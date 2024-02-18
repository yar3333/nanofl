package js.three.renderers.shaders;

extern interface ShaderLibShader {
	var uniforms : Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>;
	var vertexShader : String;
	var fragmentShader : String;
}