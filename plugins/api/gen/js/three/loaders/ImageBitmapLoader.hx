package js.three.loaders;

@:native("THREE.ImageBitmapLoader") extern class ImageBitmapLoader extends js.three.loaders.Loader<js.html.ImageBitmap, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	/**
		
			 * @default { premultiplyAlpha: 'none' }
			 
	**/
	var options : Dynamic;
	var isImageBitmapLoader(default, null) : Bool;
	override function load(url:String, ?onLoad:js.html.ImageBitmap -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):Void;
	function setOptions(options:Dynamic):js.three.loaders.ImageBitmapLoader;
}