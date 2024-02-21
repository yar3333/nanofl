package js.three.loaders;

@:native("THREE.MaterialLoader") extern class MaterialLoader extends js.three.loaders.Loader<js.three.materials.Material, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	/**
		
			 * @default {}
			 
	**/
	var textures : Dynamic<js.three.textures.Texture>;
	function parse(json:Dynamic):js.three.materials.Material;
	function setTextures(textures:Dynamic<js.three.textures.Texture>):js.three.loaders.MaterialLoader;
	static function createMaterialFromType(type:String):js.three.materials.Material;
}