package soundjs.cordovaaudio;

/**
 * Loader provides a mechanism to preload Cordova audio content via PreloadJS or internally. Instances are returned to
 * the preloader, and the load method is called when the asset needs to be requested.
 * Currently files are assumed to be local and no loading actually takes place.  This class exists to more easily support
 * the existing architecture.
 */
/**
	
	 * Loader provides a mechanism to preload Cordova audio content via PreloadJS or internally. Instances are returned to
	 * the preloader, and the load method is called when the asset needs to be requested.
	 * Currently files are assumed to be local and no loading actually takes place.  This class exists to more easily support
	 * the existing architecture.
	 
**/
@:native('createjs.CordovaAudioLoader') extern class CordovaAudioLoader extends preloadjs.net.XHRRequest {

}