package js.three.materials;

@:native("THREE.SpriteMaterial") extern class SpriteMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.SpriteMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link SpriteMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isSpriteMaterial(default, null) : Bool;
	/**
		
			 * @default new THREE.Color( 0xffffff )
			 
	**/
	var color : js.three.math.Color;
	/**
		
			 * @default null
			 
	**/
	var map : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var alphaMap : js.three.textures.Texture;
	/**
		
			 * @default 0
			 
	**/
	var rotation : Float;
	/**
		
			 * @default true
			 
	**/
	var sizeAttenuation : Bool;
	/**
		
			 * Whether the material is affected by fog. Default is true.
			 * @default fog
			 
	**/
	var fog : Bool;
	override function setValues(parameters:js.three.materials.SpriteMaterialParameters):Void;
	override function copy(source:js.three.materials.SpriteMaterial):js.three.materials.SpriteMaterial;
}