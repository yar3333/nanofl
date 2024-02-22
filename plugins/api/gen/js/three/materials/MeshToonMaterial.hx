package js.three.materials;

@:native("THREE.MeshToonMaterial") extern class MeshToonMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.MeshToonMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link MeshToonMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isMeshToonMaterial(default, null) : Bool;
	/**
		
			 * @default new THREE.Color( 0xffffff )
			 
	**/
	var color : js.three.math.Color;
	/**
		
			 * @default null
			 
	**/
	var gradientMap : js.three.textures.Texture;
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
		
			 * @default new THREE.Color( 0x000000 )
			 
	**/
	var emissive : js.three.math.Color;
	/**
		
			 * @default 1
			 
	**/
	var emissiveIntensity : Float;
	/**
		
			 * @default null
			 
	**/
	var emissiveMap : js.three.textures.Texture;
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
		
			 * @default new THREE.Vector2( 1, 1 )
			 
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
	override function setValues(parameters:js.three.materials.MeshToonMaterialParameters):Void;
}