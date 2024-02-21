package js.three.loaders;

/**
 * Class for loading a texture.
 * Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
 */
/**
	
	 * Class for loading a texture.
	 * Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
	 
**/
@:native("THREE.TextureLoader") extern class TextureLoader extends js.three.loaders.Loader<js.three.textures.Texture, String> {
	/**
		
			 * Class for loading a texture.
			 * Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
			 
	**/
	function new(?manager:js.three.loaders.LoadingManager):Void;
	override function load(url:String, ?onLoad:js.three.textures.Texture -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):js.three.textures.Texture;
}