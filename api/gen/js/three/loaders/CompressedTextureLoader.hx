package js.three.loaders;

@:native("THREE.CompressedTextureLoader") extern class CompressedTextureLoader extends js.three.loaders.Loader<js.three.textures.CompressedTexture, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	override function load(url:String, ?onLoad:js.three.textures.CompressedTexture -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):js.three.textures.CompressedTexture;
}