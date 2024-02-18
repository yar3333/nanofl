package js.three.renderers.shaders;

@:native("THREE") extern class UniformsTools {
	static function cloneUniforms<T:(Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>)>(uniformsSrc:T):T;
	static function mergeUniforms(uniforms:Array<Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>>):Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>;
	static function cloneUniformsGroups(src:Array<js.three.core.UniformsGroup>):Array<js.three.core.UniformsGroup>;
}