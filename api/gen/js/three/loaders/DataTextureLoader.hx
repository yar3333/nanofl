package js.three.loaders;

@:native("THREE.DataTextureLoader") extern class DataTextureLoader extends js.three.loaders.Loader<js.three.textures.DataTexture, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	override function load(url:String, ?onLoad:(js.three.textures.DataTexture, Dynamic) -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):js.three.textures.DataTexture;
}