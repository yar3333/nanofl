package js.three.renderers.webgl;

extern interface WebGLProgramParametersWithUniforms extends js.three.renderers.webgl.WebGLProgramParameters {
	var uniforms : Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>;
}