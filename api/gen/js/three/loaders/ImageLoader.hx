package js.three.loaders;

/**
 * A loader for loading an image.
 * Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
 */
/**
	
	 * A loader for loading an image.
	 * Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
	 
**/
@:native("THREE.ImageLoader") extern class ImageLoader extends js.three.loaders.Loader<js.html.ImageElement, String> {
	/**
		
			 * A loader for loading an image.
			 * Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
			 
	**/
	function new(?manager:js.three.loaders.LoadingManager):Void;
	override function load(url:String, ?onLoad:js.html.ImageElement -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):js.html.ImageElement;
}