package js.three.materials;

@:native("THREE.MeshNormalMaterial") extern class MeshNormalMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.MeshNormalMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link MeshNormalMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isMeshNormalMaterial(default, null) : Bool;
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
		
			 * @default false
			 
	**/
	var wireframe : Bool;
	/**
		
			 * @default 1
			 
	**/
	var wireframeLinewidth : Float;
	/**
		
			 * Define whether the material is rendered with flat shading. Default is false.
			 * @default false
			 
	**/
	var flatShading : Bool;
	override function setValues(parameters:js.three.materials.MeshNormalMaterialParameters):Void;
}