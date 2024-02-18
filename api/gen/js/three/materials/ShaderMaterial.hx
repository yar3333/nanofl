package js.three.materials;

@:native("THREE.ShaderMaterial") extern class ShaderMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.ShaderMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link ShaderMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isShaderMaterial(default, null) : Bool;
	/**
		
			 * @default {}
			 
	**/
	var uniforms : Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>;
	var uniformsGroups : Array<js.three.core.UniformsGroup>;
	var vertexShader : String;
	var fragmentShader : String;
	/**
		
			 * @default 1
			 
	**/
	var linewidth : Float;
	/**
		
			 * @default false
			 
	**/
	var wireframe : Bool;
	/**
		
			 * @default 1
			 
	**/
	var wireframeLinewidth : Float;
	/**
		
			 * @default false
			 
	**/
	var fog : Bool;
	/**
		
			 * @default false
			 
	**/
	var lights : Bool;
	/**
		
			 * @default false
			 
	**/
	var clipping : Bool;
	/**
		
			 * @deprecated Use {@link ShaderMaterial#extensions.derivatives extensions.derivatives} instead.
			 
	**/
	var derivatives : Dynamic;
	/**
		
			 * @default {
			 *   derivatives: false,
			 *   fragDepth: false,
			 *   drawBuffers: false,
			 *   shaderTextureLOD: false,
			 *   clipCullDistance: false,
			 *   multiDraw: false
			 * }
			 
	**/
	var extensions : { var clipCullDistance : Bool; var derivatives : Bool; var drawBuffers : Bool; var fragDepth : Bool; var multiDraw : Bool; var shaderTextureLOD : Bool; };
	/**
		
			 * @default { 'color': [ 1, 1, 1 ], 'uv': [ 0, 0 ], 'uv1': [ 0, 0 ] }
			 
	**/
	var defaultAttributeValues : Dynamic;
	/**
		
			 * @default undefined
			 
	**/
	var index0AttributeName : haxe.extern.EitherType<String, { }>;
	/**
		
			 * @default false
			 
	**/
	var uniformsNeedUpdate : Bool;
	/**
		
			 * @default null
			 
	**/
	var glslVersion : js.three.GLSLVersion;
	override function setValues(parameters:js.three.materials.ShaderMaterialParameters):Void;
	override function toJSON(meta:Dynamic):Dynamic;
}