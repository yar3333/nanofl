package js.three.core;

/**
 * @see Example: {@link https://threejs.org/examples/#webgl2_ubo | WebGL2 / UBO}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/UniformsGroup.js | Source}
 */
/**
	
	 * @see Example: {@link https://threejs.org/examples/#webgl2_ubo | WebGL2 / UBO}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/UniformsGroup.js | Source}
	 
**/
@:native("THREE.UniformsGroup") extern class UniformsGroup extends js.three.core.EventDispatcher<{ var dispose : { }; }> {
	/**
		
			 * @see Example: {@link https://threejs.org/examples/#webgl2_ubo | WebGL2 / UBO}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/UniformsGroup.js | Source}
			 
	**/
	function new():Void;
	var isUniformsGroup(default, null) : Bool;
	var id : Int;
	var usage : js.three.Usage;
	var uniforms : Array<haxe.extern.EitherType<js.three.core.Uniform<Dynamic>, Array<js.three.core.Uniform<Dynamic>>>>;
	function add(uniform:haxe.extern.EitherType<js.three.core.Uniform<Dynamic>, Array<js.three.core.Uniform<Dynamic>>>):js.three.core.UniformsGroup;
	function remove(uniform:haxe.extern.EitherType<js.three.core.Uniform<Dynamic>, Array<js.three.core.Uniform<Dynamic>>>):js.three.core.UniformsGroup;
	function setName(name:String):js.three.core.UniformsGroup;
	function setUsage(value:js.three.Usage):js.three.core.UniformsGroup;
	function dispose():js.three.core.UniformsGroup;
	function copy(source:js.three.core.UniformsGroup):js.three.core.UniformsGroup;
	function clone():js.three.core.UniformsGroup;
}