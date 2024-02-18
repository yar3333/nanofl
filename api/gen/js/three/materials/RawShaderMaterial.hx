package js.three.materials;

@:native("THREE.RawShaderMaterial") extern class RawShaderMaterial extends js.three.materials.ShaderMaterial {
	function new(?parameters:js.three.materials.ShaderMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link RawShaderMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isRawShaderMaterial(default, null) : Bool;
}