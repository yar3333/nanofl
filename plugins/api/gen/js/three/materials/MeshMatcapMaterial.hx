package js.three.materials;

@:native("THREE.MeshMatcapMaterial") extern class MeshMatcapMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.MeshMatcapMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link MeshMatcapMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isMeshMatcapMaterial(default, null) : Bool;
	/**
		
			 * @default new THREE.Color( 0xffffff )
			 
	**/
	var color : js.three.math.Color;
	/**
		
			 * @default null
			 
	**/
	var matcap : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var map : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var bumpMap : js.three.textures.Texture;
	/**
		
			 * @default 1
			 
	**/
	var bumpScale : Float;
	/**
		
			 * @default null
			 
	**/
	var normalMap : js.three.textures.Texture;
	/**
		
			 * @default THREE.TangentSpaceNormalMap
			 
	**/
	var normalMapType : js.three.NormalMapTypes;
	/**
		
			 * @default new Vector2( 1, 1 )
			 
	**/
	var normalScale : js.three.math.Vector2;
	/**
		
			 * @default null
			 
	**/
	var displacementMap : js.three.textures.Texture;
	/**
		
			 * @default 1
			 
	**/
	var displacementScale : Float;
	/**
		
			 * @default 0
			 
	**/
	var displacementBias : Float;
	/**
		
			 * @default null
			 
	**/
	var alphaMap : js.three.textures.Texture;
	/**
		
			 * Define whether the material is rendered with flat shading. Default is false.
			 * @default false
			 
	**/
	var flatShading : Bool;
	/**
		
			 * Whether the material is affected by fog. Default is true.
			 * @default fog
			 
	**/
	var fog : Bool;
	override function setValues(parameters:js.three.materials.MeshMatcapMaterialParameters):Void;
}