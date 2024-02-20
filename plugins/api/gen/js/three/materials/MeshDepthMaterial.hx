package js.three.materials;

@:native("THREE.MeshDepthMaterial") extern class MeshDepthMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.MeshDepthMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link MeshDepthMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isMeshDepthMaterial(default, null) : Bool;
	/**
		
			 * @default null
			 
	**/
	var map : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var alphaMap : js.three.textures.Texture;
	/**
		
			 * @default THREE.BasicDepthPacking
			 
	**/
	var depthPacking : js.three.DepthPackingStrategies;
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
		
			 * @default false
			 
	**/
	var fog : Bool;
	override function setValues(parameters:js.three.materials.MeshDepthMaterialParameters):Void;
}