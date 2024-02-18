package preloadjs.loaders;

/**
 * The base loader, which defines all the generic methods, properties, and events. All loaders extend this class,
 * including the {{#crossLink "LoadQueue"}}{{/crossLink}}.
 */
/**
	
	 * The base loader, which defines all the generic methods, properties, and events. All loaders extend this class,
	 * including the {{#crossLink "LoadQueue"}}{{/crossLink}}.
	 
**/
@:native('createjs.AbstractLoader') extern class AbstractLoader extends createjs.events.EventDispatcher {
	/**
		
			 * If the loader has completed loading. This provides a quick check, but also ensures that the different approaches
			 * used for loading do not pile up resulting in more than one `complete` {{#crossLink "Event"}}{{/crossLink}}.
			 
	**/
	var loaded : Bool;
	/**
		
			 * Determine if the loader was canceled. Canceled loads will not fire complete events. Note that this property
			 * is readonly, so {{#crossLink "LoadQueue"}}{{/crossLink}} queues should be closed using {{#crossLink "LoadQueue/close"}}{{/crossLink}}
			 * instead.
			 
	**/
	var canceled : Bool;
	/**
		
			 * The current load progress (percentage) for this item. This will be a number between 0 and 1.
			 * 
			 * <h4>Example</h4>
			 * 
			 *     var queue = new createjs.LoadQueue();
			 *     queue.loadFile("largeImage.png");
			 *     queue.on("progress", function() {
			 *         console.log("Progress:", queue.progress, event.progress);
			 *     });
			 
	**/
	var progress : Float;
	/**
		
			 * The type of item this loader will load. See {{#crossLink "AbstractLoader"}}{{/crossLink}} for a full list of
			 * supported types.
			 
	**/
	var type : preloadjs.data.Types;
	/**
		
			 * A custom result formatter function, which is called just before a request dispatches its complete event. Most
			 * loader types already have an internal formatter, but this can be user-overridden for custom formatting. The
			 * formatted result will be available on Loaders using {{#crossLink "getResult"}}{{/crossLink}}, and passing `true`.
			 
	**/
	var resultFormatter : Dynamic;
	/**
		
			 * Get a reference to the manifest item that is loaded by this loader. In some cases this will be the value that was
			 * passed into {{#crossLink "LoadQueue"}}{{/crossLink}} using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or
			 * {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. However if only a String path was passed in, then it will
			 * be a {{#crossLink "LoadItem"}}{{/crossLink}}.
			 
	**/
	function getItem(?value:String):Dynamic;
	/**
		
			 * Get a reference to the content that was loaded by the loader (only available after the {{#crossLink "complete:event"}}{{/crossLink}}
			 * event is dispatched.
			 
	**/
	function getResult(?raw:Dynamic, ?rawResult:Bool):Dynamic;
	/**
		
			 * Return the `tag` this object creates or uses for loading.
			 
	**/
	function getTag():Dynamic;
	/**
		
			 * Set the `tag` this item uses for loading.
			 
	**/
	function setTag(tag:Dynamic):Void;
	/**
		
			 * Begin loading the item. This method is required when using a loader by itself.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var queue = new createjs.LoadQueue();
			 *      queue.on("complete", handleComplete);
			 *      queue.loadManifest(fileArray, false); // Note the 2nd argument that tells the queue not to start loading yet
			 *      queue.load();
			 
	**/
	function load():Void;
	/**
		
			 * Close the the item. This will stop any open requests (although downloads using HTML tags may still continue in
			 * the background), but events will not longer be dispatched.
			 
	**/
	function cancel():Void;
	/**
		
			 * Clean up the loader.
			 
	**/
	function destroy():Void;
	/**
		
			 * Get any items loaded internally by the loader. The enables loaders such as {{#crossLink "ManifestLoader"}}{{/crossLink}}
			 * to expose items it loads internally.
			 
	**/
	function getLoadedItems():Array<Dynamic>;
	override function toString():String;
}

typedef AbstractLoaderLoadstartEvent = {
	var target : Dynamic;
	var type : String;
};

typedef AbstractLoaderCompleteEvent = {
	var target : Dynamic;
	var type : String;
};

typedef AbstractLoaderFileerrorEvent = {
	var The : Dynamic;
	var target : Dynamic;
	var type : String;
};

typedef AbstractLoaderFileloadEvent = {
	var item : Dynamic;
	var rawResult : Dynamic;
	var result : Dynamic;
	var target : Dynamic;
	var type : String;
};

typedef AbstractLoaderInitializeEvent = {
	var loader : preloadjs.loaders.AbstractLoader;
	var target : Dynamic;
	var type : String;
};