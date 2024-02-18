package js.three.renderers.webgl;

@:native("THREE") extern class WebGLTools {
	static function WebGLShader(gl:js.html.webgl.RenderingContext, type:String, string:String):js.html.webgl.Shader;
	static function WebGLUniformsGroups(gl:js.html.webgl.RenderingContext, info:js.three.renderers.webgl.WebGLInfo, capabilities:js.three.renderers.webgl.WebGLCapabilities, state:js.three.renderers.webgl.WebGLState):{ var bind : (js.three.core.UniformsGroup, js.three.renderers.webgl.WebGLProgram) -> Void; var dispose : () -> Void; var update : (js.three.core.UniformsGroup, js.three.renderers.webgl.WebGLProgram) -> Void; };
}