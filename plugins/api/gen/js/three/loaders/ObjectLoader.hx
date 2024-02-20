package js.three.loaders;

@:native("THREE.ObjectLoader") extern class ObjectLoader extends js.three.loaders.Loader<js.three.core.Object3D<js.three.core.Object3DEventMap>, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	override function load(url:String, ?onLoad:js.three.core.Object3D<js.three.core.Object3DEventMap> -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):Void;
	function parse(json:Dynamic, ?onLoad:js.three.core.Object3D<js.three.core.Object3DEventMap> -> Void):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	function parseAsync(json:Dynamic):js.lib.Promise<js.three.core.Object3D<js.three.core.Object3DEventMap>>;
	function parseGeometries(json:Dynamic):Dynamic<haxe.extern.EitherType<js.three.core.InstancedBufferGeometry, js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>>>;
	function parseMaterials(json:Dynamic, textures:Dynamic<js.three.textures.Texture>):Dynamic<js.three.materials.Material>;
	function parseAnimations(json:Dynamic):Dynamic<js.three.animation.AnimationClip>;
	function parseImages(json:Dynamic, ?onLoad:() -> Void):Dynamic<js.three.textures.Source>;
	function parseImagesAsync(json:Dynamic):js.lib.Promise<Dynamic<js.three.textures.Source>>;
	function parseTextures(json:Dynamic, images:Dynamic<js.three.textures.Source>):Dynamic<js.three.textures.Texture>;
	function parseObject(data:Dynamic, geometries:Dynamic<haxe.extern.EitherType<js.three.core.InstancedBufferGeometry, js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>>>, materials:Dynamic<js.three.materials.Material>, animations:Dynamic<js.three.animation.AnimationClip>):js.three.core.Object3D<js.three.core.Object3DEventMap>;
}