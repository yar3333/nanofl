package js.three.loaders;

@:native("THREE.CubeTextureLoader") extern class CubeTextureLoader extends js.three.loaders.Loader<js.three.textures.CubeTexture, Array<String>> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	override function load(url:String, ?onLoad:js.three.textures.CubeTexture -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):js.three.textures.CubeTexture;
}