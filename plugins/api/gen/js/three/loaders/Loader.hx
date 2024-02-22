package js.three.loaders;

/**
 * Base class for implementing loaders.
 */
/**
	
	 * Base class for implementing loaders.
	 
**/
@:native("THREE.Loader") extern class Loader<TData, TUrl> {
	/**
		
			 * Base class for implementing loaders.
			 
	**/
	function new(?manager:js.three.loaders.LoadingManager):Void;
	/**
		
			 * @default 'anonymous'
			 
	**/
	var crossOrigin : String;
	/**
		
			 * @default false
			 
	**/
	var withCredentials : Bool;
	/**
		
			 * @default ''
			 
	**/
	var path : String;
	/**
		
			 * @default ''
			 
	**/
	var resourcePath : String;
	var manager : js.three.loaders.LoadingManager;
	/**
		
			 * @default {}
			 
	**/
	var requestHeader : Dynamic<String>;
	function load(url:TUrl, onLoad:TData -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):Void;
	function loadAsync(url:TUrl, ?onProgress:js.html.ProgressEvent -> Void):js.lib.Promise<TData>;
	function setCrossOrigin(crossOrigin:String):js.three.loaders.Loader<TData, TUrl>;
	function setWithCredentials(value:Bool):js.three.loaders.Loader<TData, TUrl>;
	function setPath(path:String):js.three.loaders.Loader<TData, TUrl>;
	function setResourcePath(resourcePath:String):js.three.loaders.Loader<TData, TUrl>;
	function setRequestHeader(requestHeader:Dynamic<String>):js.three.loaders.Loader<TData, TUrl>;
	static var DEFAULT_MATERIAL_NAME : String;
}