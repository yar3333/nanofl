package preloadjs.loaders;

/**
 * The AbstractMediaLoader is a base class that handles some of the shared methods and properties of loaders that
 * handle HTML media elements, such as Video and Audio.
 */
/**
	
	 * The AbstractMediaLoader is a base class that handles some of the shared methods and properties of loaders that
	 * handle HTML media elements, such as Video and Audio.
	 
**/
@:native('createjs.AbstractMediaLoader') extern class AbstractMediaLoader extends preloadjs.loaders.AbstractLoader {
	function new(loadItem:Dynamic, preferXHR:Bool, type:preloadjs.data.Types):Void;
}