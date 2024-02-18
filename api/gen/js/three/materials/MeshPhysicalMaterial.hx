package js.three.materials;

@:native("THREE.MeshPhysicalMaterial") extern class MeshPhysicalMaterial extends js.three.materials.MeshStandardMaterial {
	function new(?parameters:js.three.materials.MeshPhysicalMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link MeshPhysicalMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isMeshPhysicalMaterial(default, null) : Bool;
	/**
		
			 * @default 0
			 
	**/
	var clearcoat : Float;
	/**
		
			 * @default null
			 
	**/
	var clearcoatMap : js.three.textures.Texture;
	/**
		
			 * @default 0
			 
	**/
	var clearcoatRoughness : Float;
	/**
		
			 * @default null
			 
	**/
	var clearcoatRoughnessMap : js.three.textures.Texture;
	/**
		
			 * @default new THREE.Vector2( 1, 1 )
			 
	**/
	var clearcoatNormalScale : js.three.math.Vector2;
	/**
		
			 * @default null
			 
	**/
	var clearcoatNormalMap : js.three.textures.Texture;
	/**
		
			 * @default 0.5
			 
	**/
	var reflectivity : Float;
	/**
		
			 * @default 1.5
			 
	**/
	var ior : Float;
	/**
		
			 * @default 0.0
			 
	**/
	var sheen : Float;
	/**
		
			 * @default Color( 0x000000 )
			 
	**/
	var sheenColor : js.three.math.Color;
	/**
		
			 * @default null
			 
	**/
	var sheenColorMap : js.three.textures.Texture;
	/**
		
			 * @default 1.0
			 
	**/
	var sheenRoughness : Float;
	/**
		
			 * @default null
			 
	**/
	var sheenRoughnessMap : js.three.textures.Texture;
	/**
		
			 * @default 0
			 
	**/
	var transmission : Float;
	/**
		
			 * @default null
			 
	**/
	var transmissionMap : js.three.textures.Texture;
	/**
		
			 * @default 0.01
			 
	**/
	var thickness : Float;
	/**
		
			 * @default null
			 
	**/
	var thicknessMap : js.three.textures.Texture;
	/**
		
			 * @default 0.0
			 
	**/
	var attenuationDistance : Float;
	/**
		
			 * @default Color( 1, 1, 1 )
			 
	**/
	var attenuationColor : js.three.math.Color;
	/**
		
			 * @default 1.0
			 
	**/
	var specularIntensity : Float;
	/**
		
			 * @default Color(1, 1, 1)
			 
	**/
	var specularColor : js.three.math.Color;
	/**
		
			 * @default null
			 
	**/
	var specularIntensityMap : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var specularColorMap : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var iridescenceMap : js.three.textures.Texture;
	/**
		
			 * @default 1.3
			 
	**/
	var iridescenceIOR : Float;
	/**
		
			 * @default 0
			 
	**/
	var iridescence : Float;
	/**
		
			 * @default [100, 400]
			 
	**/
	var iridescenceThicknessRange : Array<Float>;
	/**
		
			 * @default null
			 
	**/
	var iridescenceThicknessMap : js.three.textures.Texture;
	/**
		
			 * @default 0
			 
	**/
	@:optional
	var anisotropy : Int;
	/**
		
			 * @default 0
			 
	**/
	@:optional
	var anisotropyRotation : Float;
	/**
		
			 * @default null
			 
	**/
	@:optional
	var anisotropyMap : js.three.textures.Texture;
}