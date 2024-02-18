package js.three.materials;

@:native("THREE.PointsMaterial") extern class PointsMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.PointsMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link PointsMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isPointsMaterial(default, null) : Bool;
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
		
			 * @default 1
			 
	**/
	var size : Float;
	/**
		
			 * @default true
			 
	**/
	var sizeAttenuation : Bool;
	/**
		
			 * Whether the material is affected by fog. Default is true.
			 * @default fog
			 
	**/
	var fog : Bool;
	override function setValues(parameters:js.three.materials.PointsMaterialParameters):Void;
}