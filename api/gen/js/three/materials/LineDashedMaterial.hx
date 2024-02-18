package js.three.materials;

@:native("THREE.LineDashedMaterial") extern class LineDashedMaterial extends js.three.materials.LineBasicMaterial {
	function new(?parameters:js.three.materials.LineDashedMaterialParameters):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link LineDashedMaterial}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isLineDashedMaterial(default, null) : Bool;
	/**
		
			 * @default 1
			 
	**/
	var scale : Float;
	/**
		
			 * @default 1
			 
	**/
	var dashSize : Float;
	/**
		
			 * @default 1
			 
	**/
	var gapSize : Float;
	override function setValues(parameters:js.three.materials.LineDashedMaterialParameters):Void;
}