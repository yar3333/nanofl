package js.three.materials;

@:native("THREE.LineBasicMaterial") extern class LineBasicMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.LineBasicMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link LineBasicMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isLineBasicMaterial(default, null) : Bool;
	/**
		
			 * @default 0xffffff
			 
	**/
	var color : js.three.math.Color;
	/**
		
			 * Whether the material is affected by fog. Default is true.
			 * @default true
			 
	**/
	var fog : Bool;
	/**
		
			 * @default 1
			 
	**/
	var linewidth : Float;
	/**
		
			 * @default 'round'
			 
	**/
	var linecap : String;
	/**
		
			 * @default 'round'
			 
	**/
	var linejoin : String;
	/**
		
			 * Sets the color of the lines using data from a {@link Texture}.
			 
	**/
	var map : js.three.textures.Texture;
	override function setValues(parameters:js.three.materials.LineBasicMaterialParameters):Void;
}