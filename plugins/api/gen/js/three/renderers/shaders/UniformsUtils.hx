package js.three.renderers.shaders;

@:native("THREE.UniformsUtils") extern class UniformsUtils {
	static function clone<T:(Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>)>(uniformsSrc:T):T;
	static function merge(uniforms:Array<Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>>):Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>;
}