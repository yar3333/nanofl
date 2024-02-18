package soundjs.webaudio;

/**
 * Loader provides a mechanism to preload Web Audio content via PreloadJS or internally. Instances are returned to
 * the preloader, and the load method is called when the asset needs to be requested.
 */
/**
	
	 * Loader provides a mechanism to preload Web Audio content via PreloadJS or internally. Instances are returned to
	 * the preloader, and the load method is called when the asset needs to be requested.
	 
**/
@:native('createjs.WebAudioLoader') extern class WebAudioLoader extends preloadjs.net.XHRRequest {
	/**
		
			 * web audio context required for decoding audio
			 
	**/
	static var context : js.html.audio.AudioContext;
}