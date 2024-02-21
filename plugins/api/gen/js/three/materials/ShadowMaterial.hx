package js.three.materials;

@:native("THREE.ShadowMaterial") extern class ShadowMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.ShadowMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link ShadowMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isShadowMaterial(default, null) : Bool;
	/**
		
			 * @default new THREE.Color( 0x000000 )
			 
	**/
	var color : js.three.math.Color;
	/**
		
			 * Whether the material is affected by fog. Default is true.
			 * @default fog
			 
	**/
	var fog : Bool;
}