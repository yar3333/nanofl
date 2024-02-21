package js.three.materials;

@:native("THREE.MeshDistanceMaterial") extern class MeshDistanceMaterial extends js.three.materials.Material {
	function new(?parameters:js.three.materials.MeshDistanceMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link MeshDistanceMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isMeshDistanceMaterial(default, null) : Bool;
	/**
		
			 * @default null
			 
	**/
	var map : js.three.textures.Texture;
	/**
		
			 * @default null
			 
	**/
	var alphaMap : js.three.textures.Texture;
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
	var fog : Bool;
	override function setValues(parameters:js.three.materials.MeshDistanceMaterialParameters):Void;
}