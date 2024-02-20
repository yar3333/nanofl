package js.three.materials;

@:native("THREE.MeshBasicMaterial") extern class MeshBasicMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.MeshBasicMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link MeshBasicMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isMeshBasicMaterial(default, null) : Bool;
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
	var lightMap : js.three.textures.Texture;
	/**
		
			 * @default 1
			 
	**/
	var lightMapIntensity : Float;
	/**
		
			 * @default null
			 
	**/
	var aoMap : js.three.textures.Texture;
	/**
		
			 * @default 1
			 
	**/
	var aoMapIntensity : Float;
	/**
		
			 * @default null
			 
	**/
	var specularMap : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var alphaMap : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var envMap : js.three.textures.Texture;
	/**
		
			 * @default THREE.MultiplyOperation
			 
	**/
	var combine : js.three.Combine;
	/**
		
			 * @default 1
			 
	**/
	var reflectivity : Float;
	/**
		
			 * @default 0.98
			 
	**/
	var refractionRatio : Float;
	/**
		
			 * @default false
			 
	**/
	var wireframe : Bool;
	/**
		
			 * @default 1
			 
	**/
	var wireframeLinewidth : Float;
	/**
		
			 * @default 'round'
			 
	**/
	var wireframeLinecap : String;
	/**
		
			 * @default 'round'
			 
	**/
	var wireframeLinejoin : String;
	/**
		
			 * Whether the material is affected by fog. Default is true.
			 * @default fog
			 
	**/
	var fog : Bool;
	override function setValues(parameters:js.three.materials.MeshBasicMaterialParameters):Void;
}