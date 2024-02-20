package preloadjs;

typedef LoadQueueFileloadEvent = {
	var item : Dynamic;
	var rawResult : Dynamic;
	var result : Dynamic;
	var target : Dynamic;
	var type : String;
};

typedef LoadQueueFilestartEvent = {
	var item : Dynamic;
	var target : Dynamic;
	var type : String;
};

/**
 * The LoadQueue class is the main API for preloading content. LoadQueue is a load manager, which can preload either
 * a single file, or queue of files.
 *
 * <b>Creating a Queue</b><br />
 * To use LoadQueue, create a LoadQueue instance. If you want to force tag loading where possible, set the preferXHR
 * argument to false.
 *
 *      var queue = new createjs.LoadQueue(true);
 *
 * <b>Listening for Events</b><br />
 * Add any listeners you want to the queue. Since PreloadJS 0.3.0, the {{#crossLink "EventDispatcher"}}{{/crossLink}}
 * lets you add as many listeners as you want for events. You can subscribe to the following events:<ul>
 *     <li>{{#crossLink "AbstractLoader/complete:event"}}{{/crossLink}}: fired when a queue completes loading all
 *     files</li>
 *     <li>{{#crossLink "AbstractLoader/error:event"}}{{/crossLink}}: fired when the queue encounters an error with
 *     any file.</li>
 *     <li>{{#crossLink "AbstractLoader/progress:event"}}{{/crossLink}}: Progress for the entire queue has
 *     changed.</li>
 *     <li>{{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}: A single file has completed loading.</li>
 *     <li>{{#crossLink "LoadQueue/fileprogress:event"}}{{/crossLink}}: Progress for a single file has changes. Note
 *     that only files loaded with XHR (or possibly by plugins) will fire progress events other than 0 or 100%.</li>
 * </ul>
 *
 *      queue.on("fileload", handleFileLoad, this);
 *      queue.on("complete", handleComplete, this);
 *
 * <b>Adding files and manifests</b><br />
 * Add files you want to load using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or add multiple files at a
 * time using a list or a manifest definition using {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. Files are
 * appended to the end of the active queue, so you can use these methods as many times as you like, whenever you
 * like.
 *
 *      queue.loadFile("filePath/file.jpg");
 *      queue.loadFile({id:"image", src:"filePath/file.jpg"});
 *      queue.loadManifest(["filePath/file.jpg", {id:"image", src:"filePath/file.jpg"}]);
 *
 *      // Use an external manifest
 *      queue.loadManifest("path/to/manifest.json");
 *      queue.loadManifest({src:"manifest.json", type:"manifest"});
 *
 * If you pass `false` as the `loadNow` parameter, the queue will not kick of the load of the files, but it will not
 * stop if it has already been started. Call the {{#crossLink "AbstractLoader/load"}}{{/crossLink}} method to begin
 * a paused queue. Note that a paused queue will automatically resume when new files are added to it with a
 * `loadNow` argument of `true`.
 *
 *      queue.load();
 *
 * <b>File Types</b><br />
 * The file type of a manifest item is auto-determined by the file extension. The pattern matching in PreloadJS
 * should handle the majority of standard file and url formats, and works with common file extensions. If you have
 * either a non-standard file extension, or are serving the file using a proxy script, then you can pass in a
 * <code>type</code> property with any manifest item.
 *
 *      queue.loadFile({src:"path/to/myFile.mp3x", type:createjs.Types.SOUND});
 *
 *      // Note that PreloadJS will not read a file extension from the query string
 *      queue.loadFile({src:"http://server.com/proxy?file=image.jpg", type:createjs.Types.IMAGE});
 *
 * Supported types are defined on the {{#crossLink "AbstractLoader"}}{{/crossLink}} class, and include:
 * <ul>
 *     <li>{{#crossLink "Types/BINARY:property"}}{{/crossLink}}: Raw binary data via XHR</li>
 *     <li>{{#crossLink "Types/CSS:property"}}{{/crossLink}}: CSS files</li>
 *     <li>{{#crossLink "Types/IMAGE:property"}}{{/crossLink}}: Common image formats</li>
 *     <li>{{#crossLink "Types/JAVASCRIPT:property"}}{{/crossLink}}: JavaScript files</li>
 *     <li>{{#crossLink "Types/JSON:property"}}{{/crossLink}}: JSON data</li>
 *     <li>{{#crossLink "Types/JSONP:property"}}{{/crossLink}}: JSON files cross-domain</li>
 *     <li>{{#crossLink "Types/MANIFEST:property"}}{{/crossLink}}: A list of files to load in JSON format, see
 *     {{#crossLink "AbstractLoader/loadManifest"}}{{/crossLink}}</li>
 *     <li>{{#crossLink "Types/SOUND:property"}}{{/crossLink}}: Audio file formats</li>
 *     <li>{{#crossLink "Types/SPRITESHEET:property"}}{{/crossLink}}: JSON SpriteSheet definitions. This
 *     will also load sub-images, and provide a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance.</li>
 *     <li>{{#crossLink "Types/SVG:property"}}{{/crossLink}}: SVG files</li>
 *     <li>{{#crossLink "Types/TEXT:property"}}{{/crossLink}}: Text files - XHR only</li>
 *     <li>{{#crossLink "Types/VIDEO:property"}}{{/crossLink}}: Video objects</li>
 *     <li>{{#crossLink "Types/XML:property"}}{{/crossLink}}: XML data</li>
 * </ul>
 *
 * <em>Note: Loader types used to be defined on LoadQueue, but have been moved to the Types class</em>
 *
 * <b>Handling Results</b><br />
 * When a file is finished downloading, a {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}} event is
 * dispatched. In an example above, there is an event listener snippet for fileload. Loaded files are usually a
 * formatted object that can be used immediately, including:
 * <ul>
 *     <li>Binary: The binary loaded result</li>
 *     <li>CSS: A &lt;link /&gt; tag</li>
 *     <li>Image: An &lt;img /&gt; tag</li>
 *     <li>JavaScript: A &lt;script /&gt; tag</li>
 *     <li>JSON/JSONP: A formatted JavaScript Object</li>
 *     <li>Manifest: A JavaScript object.
 *     <li>Sound: An &lt;audio /&gt; tag</a>
 *     <li>SpriteSheet: A {{#crossLink "SpriteSheet"}}{{/crossLink}} instance, containing loaded images.
 *     <li>SVG: An &lt;object /&gt; tag</li>
 *     <li>Text: Raw text</li>
 *     <li>Video: A Video DOM node</li>
 *     <li>XML: An XML DOM node</li>
 * </ul>
 *
 *      function handleFileLoad(event) {
 *          var item = event.item; // A reference to the item that was passed in to the LoadQueue
 *          var type = item.type;
 *
 *          // Add any images to the page body.
 *          if (type == createjs.Types.IMAGE) {
 *              document.body.appendChild(event.result);
 *          }
 *      }
 *
 * At any time after the file has been loaded (usually after the queue has completed), any result can be looked up
 * via its "id" using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}. If no id was provided, then the
 * "src" or file path can be used instead, including the `path` defined by a manifest, but <strong>not including</strong>
 * a base path defined on the LoadQueue. It is recommended to always pass an id if you want to look up content.
 *
 *      var image = queue.getResult("image");
 *      document.body.appendChild(image);
 *
 * Raw loaded content can be accessed using the <code>rawResult</code> property of the {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}
 * event, or can be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}, passing `true` as the 2nd
 * argument. This is only applicable for content that has been parsed for the browser, specifically: JavaScript,
 * CSS, XML, SVG, and JSON objects, or anything loaded with XHR.
 *
 *      var image = queue.getResult("image", true); // load the binary image data loaded with XHR.
 *
 * <b>Plugins</b><br />
 * LoadQueue has a simple plugin architecture to help process and preload content. For example, to preload audio,
 * make sure to install the <a href="http://soundjs.com">SoundJS</a> Sound class, which will help load HTML audio,
 * Flash audio, and WebAudio files. This should be installed <strong>before</strong> loading any audio files.
 *
 *      queue.installPlugin(createjs.Sound);
 *
 * <h4>Known Browser Issues</h4>
 * <ul>
 *     <li>Browsers without audio support can not load audio files.</li>
 *     <li>Safari on Mac OS X can only play HTML audio if QuickTime is installed</li>
 *     <li>HTML Audio tags will only download until their <code>canPlayThrough</code> event is fired. Browsers other
 *     than Chrome will continue to download in the background.</li>
 *     <li>When loading scripts using tags, they are automatically added to the document.</li>
 *     <li>Scripts loaded via XHR may not be properly inspectable with browser tools.</li>
 *     <li>IE6 and IE7 (and some other browsers) may not be able to load XML, Text, or JSON, since they require
 *     XHR to work.</li>
 *     <li>Content loaded via tags will not show progress, and will continue to download in the background when
 *     canceled, although no events will be dispatched.</li>
 * </ul>
 */
/**
	
	 * The LoadQueue class is the main API for preloading content. LoadQueue is a load manager, which can preload either
	 * a single file, or queue of files.
	 * 
	 * <b>Creating a Queue</b><br />
	 * To use LoadQueue, create a LoadQueue instance. If you want to force tag loading where possible, set the preferXHR
	 * argument to false.
	 * 
	 *      var queue = new createjs.LoadQueue(true);
	 * 
	 * <b>Listening for Events</b><br />
	 * Add any listeners you want to the queue. Since PreloadJS 0.3.0, the {{#crossLink "EventDispatcher"}}{{/crossLink}}
	 * lets you add as many listeners as you want for events. You can subscribe to the following events:<ul>
	 *     <li>{{#crossLink "AbstractLoader/complete:event"}}{{/crossLink}}: fired when a queue completes loading all
	 *     files</li>
	 *     <li>{{#crossLink "AbstractLoader/error:event"}}{{/crossLink}}: fired when the queue encounters an error with
	 *     any file.</li>
	 *     <li>{{#crossLink "AbstractLoader/progress:event"}}{{/crossLink}}: Progress for the entire queue has
	 *     changed.</li>
	 *     <li>{{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}: A single file has completed loading.</li>
	 *     <li>{{#crossLink "LoadQueue/fileprogress:event"}}{{/crossLink}}: Progress for a single file has changes. Note
	 *     that only files loaded with XHR (or possibly by plugins) will fire progress events other than 0 or 100%.</li>
	 * </ul>
	 * 
	 *      queue.on("fileload", handleFileLoad, this);
	 *      queue.on("complete", handleComplete, this);
	 * 
	 * <b>Adding files and manifests</b><br />
	 * Add files you want to load using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or add multiple files at a
	 * time using a list or a manifest definition using {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. Files are
	 * appended to the end of the active queue, so you can use these methods as many times as you like, whenever you
	 * like.
	 * 
	 *      queue.loadFile("filePath/file.jpg");
	 *      queue.loadFile({id:"image", src:"filePath/file.jpg"});
	 *      queue.loadManifest(["filePath/file.jpg", {id:"image", src:"filePath/file.jpg"}]);
	 * 
	 *      // Use an external manifest
	 *      queue.loadManifest("path/to/manifest.json");
	 *      queue.loadManifest({src:"manifest.json", type:"manifest"});
	 * 
	 * If you pass `false` as the `loadNow` parameter, the queue will not kick of the load of the files, but it will not
	 * stop if it has already been started. Call the {{#crossLink "AbstractLoader/load"}}{{/crossLink}} method to begin
	 * a paused queue. Note that a paused queue will automatically resume when new files are added to it with a
	 * `loadNow` argument of `true`.
	 * 
	 *      queue.load();
	 * 
	 * <b>File Types</b><br />
	 * The file type of a manifest item is auto-determined by the file extension. The pattern matching in PreloadJS
	 * should handle the majority of standard file and url formats, and works with common file extensions. If you have
	 * either a non-standard file extension, or are serving the file using a proxy script, then you can pass in a
	 * <code>type</code> property with any manifest item.
	 * 
	 *      queue.loadFile({src:"path/to/myFile.mp3x", type:createjs.Types.SOUND});
	 * 
	 *      // Note that PreloadJS will not read a file extension from the query string
	 *      queue.loadFile({src:"http://server.com/proxy?file=image.jpg", type:createjs.Types.IMAGE});
	 * 
	 * Supported types are defined on the {{#crossLink "AbstractLoader"}}{{/crossLink}} class, and include:
	 * <ul>
	 *     <li>{{#crossLink "Types/BINARY:property"}}{{/crossLink}}: Raw binary data via XHR</li>
	 *     <li>{{#crossLink "Types/CSS:property"}}{{/crossLink}}: CSS files</li>
	 *     <li>{{#crossLink "Types/IMAGE:property"}}{{/crossLink}}: Common image formats</li>
	 *     <li>{{#crossLink "Types/JAVASCRIPT:property"}}{{/crossLink}}: JavaScript files</li>
	 *     <li>{{#crossLink "Types/JSON:property"}}{{/crossLink}}: JSON data</li>
	 *     <li>{{#crossLink "Types/JSONP:property"}}{{/crossLink}}: JSON files cross-domain</li>
	 *     <li>{{#crossLink "Types/MANIFEST:property"}}{{/crossLink}}: A list of files to load in JSON format, see
	 *     {{#crossLink "AbstractLoader/loadManifest"}}{{/crossLink}}</li>
	 *     <li>{{#crossLink "Types/SOUND:property"}}{{/crossLink}}: Audio file formats</li>
	 *     <li>{{#crossLink "Types/SPRITESHEET:property"}}{{/crossLink}}: JSON SpriteSheet definitions. This
	 *     will also load sub-images, and provide a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance.</li>
	 *     <li>{{#crossLink "Types/SVG:property"}}{{/crossLink}}: SVG files</li>
	 *     <li>{{#crossLink "Types/TEXT:property"}}{{/crossLink}}: Text files - XHR only</li>
	 *     <li>{{#crossLink "Types/VIDEO:property"}}{{/crossLink}}: Video objects</li>
	 *     <li>{{#crossLink "Types/XML:property"}}{{/crossLink}}: XML data</li>
	 * </ul>
	 * 
	 * <em>Note: Loader types used to be defined on LoadQueue, but have been moved to the Types class</em>
	 * 
	 * <b>Handling Results</b><br />
	 * When a file is finished downloading, a {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}} event is
	 * dispatched. In an example above, there is an event listener snippet for fileload. Loaded files are usually a
	 * formatted object that can be used immediately, including:
	 * <ul>
	 *     <li>Binary: The binary loaded result</li>
	 *     <li>CSS: A &lt;link /&gt; tag</li>
	 *     <li>Image: An &lt;img /&gt; tag</li>
	 *     <li>JavaScript: A &lt;script /&gt; tag</li>
	 *     <li>JSON/JSONP: A formatted JavaScript Object</li>
	 *     <li>Manifest: A JavaScript object.
	 *     <li>Sound: An &lt;audio /&gt; tag</a>
	 *     <li>SpriteSheet: A {{#crossLink "SpriteSheet"}}{{/crossLink}} instance, containing loaded images.
	 *     <li>SVG: An &lt;object /&gt; tag</li>
	 *     <li>Text: Raw text</li>
	 *     <li>Video: A Video DOM node</li>
	 *     <li>XML: An XML DOM node</li>
	 * </ul>
	 * 
	 *      function handleFileLoad(event) {
	 *          var item = event.item; // A reference to the item that was passed in to the LoadQueue
	 *          var type = item.type;
	 * 
	 *          // Add any images to the page body.
	 *          if (type == createjs.Types.IMAGE) {
	 *              document.body.appendChild(event.result);
	 *          }
	 *      }
	 * 
	 * At any time after the file has been loaded (usually after the queue has completed), any result can be looked up
	 * via its "id" using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}. If no id was provided, then the
	 * "src" or file path can be used instead, including the `path` defined by a manifest, but <strong>not including</strong>
	 * a base path defined on the LoadQueue. It is recommended to always pass an id if you want to look up content.
	 * 
	 *      var image = queue.getResult("image");
	 *      document.body.appendChild(image);
	 * 
	 * Raw loaded content can be accessed using the <code>rawResult</code> property of the {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}
	 * event, or can be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}, passing `true` as the 2nd
	 * argument. This is only applicable for content that has been parsed for the browser, specifically: JavaScript,
	 * CSS, XML, SVG, and JSON objects, or anything loaded with XHR.
	 * 
	 *      var image = queue.getResult("image", true); // load the binary image data loaded with XHR.
	 * 
	 * <b>Plugins</b><br />
	 * LoadQueue has a simple plugin architecture to help process and preload content. For example, to preload audio,
	 * make sure to install the <a href="http://soundjs.com">SoundJS</a> Sound class, which will help load HTML audio,
	 * Flash audio, and WebAudio files. This should be installed <strong>before</strong> loading any audio files.
	 * 
	 *      queue.installPlugin(createjs.Sound);
	 * 
	 * <h4>Known Browser Issues</h4>
	 * <ul>
	 *     <li>Browsers without audio support can not load audio files.</li>
	 *     <li>Safari on Mac OS X can only play HTML audio if QuickTime is installed</li>
	 *     <li>HTML Audio tags will only download until their <code>canPlayThrough</code> event is fired. Browsers other
	 *     than Chrome will continue to download in the background.</li>
	 *     <li>When loading scripts using tags, they are automatically added to the document.</li>
	 *     <li>Scripts loaded via XHR may not be properly inspectable with browser tools.</li>
	 *     <li>IE6 and IE7 (and some other browsers) may not be able to load XML, Text, or JSON, since they require
	 *     XHR to work.</li>
	 *     <li>Content loaded via tags will not show progress, and will continue to download in the background when
	 *     canceled, although no events will be dispatched.</li>
	 * </ul>
	 
**/
@:native('createjs.LoadQueue') extern class LoadQueue extends preloadjs.loaders.AbstractLoader {
	function new(?preferXHR:Bool, ?basePath:String, ?crossOrigin:Dynamic):Void;
	/**
		
			 * The next preload queue to process when this one is complete. If an error is thrown in the current queue, and
			 * {{#crossLink "LoadQueue/stopOnError:property"}}{{/crossLink}} is `true`, the next queue will not be processed.
			 
	**/
	var next : preloadjs.LoadQueue;
	/**
		
			 * Ensure loaded scripts "complete" in the order they are specified. Loaded scripts are added to the document head
			 * once they are loaded. Scripts loaded via tags will load one-at-a-time when this property is `true`, whereas
			 * scripts loaded using XHR can load in any order, but will "finish" and be added to the document in the order
			 * specified.
			 * 
			 * Any items can be set to load in order by setting the {{#crossLink "maintainOrder:property"}}{{/crossLink}}
			 * property on the load item, or by ensuring that only one connection can be open at a time using
			 * {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}}. Note that when the `maintainScriptOrder` property
			 * is set to `true`, scripts items are automatically set to `maintainOrder=true`, and changing the
			 * `maintainScriptOrder` to `false` during a load will not change items already in a queue.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var queue = new createjs.LoadQueue();
			 *      queue.setMaxConnections(3); // Set a higher number to load multiple items at once
			 *      queue.maintainScriptOrder = true; // Ensure scripts are loaded in order
			 *      queue.loadManifest([
			 *          "script1.js",
			 *          "script2.js",
			 *          "image.png", // Load any time
			 *          {src: "image2.png", maintainOrder: true} // Will wait for script2.js
			 *          "image3.png",
			 *          "script3.js" // Will wait for image2.png before loading (or completing when loading with XHR)
			 *      ]);
			 
	**/
	var maintainScriptOrder : Bool;
	/**
		
			 * Determines if the LoadQueue will stop processing the current queue when an error is encountered.
			 
	**/
	var stopOnError : Bool;
	/**
		
			 * Register a custom loaders class. New loaders are given precedence over loaders added earlier and default loaders.
			 * It is recommended that loaders extend {{#crossLink "AbstractLoader"}}{{/crossLink}}. Loaders can only be added
			 * once, and will be prepended to the list of available loaders.
			 
	**/
	function registerLoader(loader:Class<preloadjs.loaders.AbstractLoader>):Void;
	/**
		
			 * Remove a custom loader added using {{#crossLink "registerLoader"}}{{/crossLink}}. Only custom loaders can be
			 * unregistered, the default loaders will always be available.
			 
	**/
	function unregisterLoader(loader:Class<preloadjs.loaders.AbstractLoader>):Void;
	/**
		
			 * Change the {{#crossLink "preferXHR:property"}}{{/crossLink}} value. Note that if this is set to `true`, it may
			 * fail, or be ignored depending on the browser's capabilities and the load type.
			 
	**/
	function setPreferXHR(value:Bool):Bool;
	/**
		
			 * Stops all queued and loading items, and clears the queue. This also removes all internal references to loaded
			 * content, and allows the queue to be used again.
			 
	**/
	function removeAll():Void;
	/**
		
			 * Stops an item from being loaded, and removes it from the queue. If nothing is passed, all items are removed.
			 * This also removes internal references to loaded item(s).
			 * 
			 * <h4>Example</h4>
			 * 
			 *      queue.loadManifest([
			 *          {src:"test.png", id:"png"},
			 *          {src:"test.jpg", id:"jpg"},
			 *          {src:"test.mp3", id:"mp3"}
			 *      ]);
			 *      queue.remove("png"); // Single item by ID
			 *      queue.remove("png", "test.jpg"); // Items as arguments. Mixed id and src.
			 *      queue.remove(["test.png", "jpg"]); // Items in an Array. Mixed id and src.
			 
	**/
	function remove(idsOrUrls:Dynamic):Void;
	/**
		
			 * Stops all open loads, destroys any loaded items, and resets the queue, so all items can
			 * be reloaded again by calling {{#crossLink "AbstractLoader/load"}}{{/crossLink}}. Items are not removed from the
			 * queue. To remove items use the {{#crossLink "LoadQueue/remove"}}{{/crossLink}} or
			 * {{#crossLink "LoadQueue/removeAll"}}{{/crossLink}} method.
			 
	**/
	function reset():Void;
	/**
		
			 * Register a plugin. Plugins can map to load types (sound, image, etc), or specific extensions (png, mp3, etc).
			 * Currently, only one plugin can exist per type/extension.
			 * 
			 * When a plugin is installed, a <code>getPreloadHandlers()</code> method will be called on it. For more information
			 * on this method, check out the {{#crossLink "SamplePlugin/getPreloadHandlers"}}{{/crossLink}} method in the
			 * {{#crossLink "SamplePlugin"}}{{/crossLink}} class.
			 * 
			 * Before a file is loaded, a matching plugin has an opportunity to modify the load. If a `callback` is returned
			 * from the {{#crossLink "SamplePlugin/getPreloadHandlers"}}{{/crossLink}} method, it will be invoked first, and its
			 * result may cancel or modify the item. The callback method can also return a `completeHandler` to be fired when
			 * the file is loaded, or a `tag` object, which will manage the actual download. For more information on these
			 * methods, check out the {{#crossLink "SamplePlugin/preloadHandler"}}{{/crossLink}} and {{#crossLink "SamplePlugin/fileLoadHandler"}}{{/crossLink}}
			 * methods on the {{#crossLink "SamplePlugin"}}{{/crossLink}}.
			 
	**/
	function installPlugin(plugin:Dynamic):Void;
	/**
		
			 * Set the maximum number of concurrent connections. Note that browsers and servers may have a built-in maximum
			 * number of open connections, so any additional connections may remain in a pending state until the browser
			 * opens the connection. When loading scripts using tags, and when {{#crossLink "LoadQueue/maintainScriptOrder:property"}}{{/crossLink}}
			 * is `true`, only one script is loaded at a time due to browser limitations.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var queue = new createjs.LoadQueue();
			 *      queue.setMaxConnections(10); // Allow 10 concurrent loads
			 
	**/
	function setMaxConnections(value:Int):Void;
	/**
		
			 * Load a single file. To add multiple files at once, use the {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}
			 * method.
			 * 
			 * Files are always appended to the current queue, so this method can be used multiple times to add files.
			 * To clear the queue first, use the {{#crossLink "AbstractLoader/close"}}{{/crossLink}} method.
			 
	**/
	function loadFile(file:Dynamic, ?loadNow:Bool, ?basePath:String):Void;
	/**
		
			 * Load an array of files. To load a single file, use the {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} method.
			 * The files in the manifest are requested in the same order, but may complete in a different order if the max
			 * connections are set above 1 using {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}}. Scripts will load
			 * in the right order as long as {{#crossLink "LoadQueue/maintainScriptOrder"}}{{/crossLink}} is true (which is
			 * default).
			 * 
			 * Files are always appended to the current queue, so this method can be used multiple times to add files.
			 * To clear the queue first, use the {{#crossLink "AbstractLoader/close"}}{{/crossLink}} method.
			 
	**/
	function loadManifest(manifest:Dynamic, ?loadNow:Bool, ?basePath:String):Void;
	/**
		
			 * Start a LoadQueue that was created, but not automatically started.
			 
	**/
	override function load():Void;
	/**
		
			 * Look up a {{#crossLink "LoadItem"}}{{/crossLink}} using either the "id" or "src" that was specified when loading it. Note that if no "id" was
			 * supplied with the load item, the ID will be the "src", including a `path` property defined by a manifest. The
			 * `basePath` will not be part of the ID.
			 
	**/
	override function getItem(?value:String):Dynamic;
	/**
		
			 * Look up a loaded result using either the "id" or "src" that was specified when loading it. Note that if no "id"
			 * was supplied with the load item, the ID will be the "src", including a `path` property defined by a manifest. The
			 * `basePath` will not be part of the ID.
			 
	**/
	override function getResult(?value:Dynamic, ?rawResult:Bool):Dynamic;
	/**
		
			 * Generate an list of items loaded by this queue.
			 
	**/
	function getItems(loaded:Bool):Array<Dynamic>;
	/**
		
			 * Pause or resume the current load. Active loads will not be cancelled, but the next items in the queue will not
			 * be processed when active loads complete. LoadQueues are not paused by default.
			 * 
			 * Note that if new items are added to the queue using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or
			 * {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}, a paused queue will be resumed, unless the `loadNow`
			 * argument is `false`.
			 
	**/
	function setPaused(value:Bool):Void;
	/**
		
			 * Close the active queue. Closing a queue completely empties the queue, and prevents any remaining items from
			 * starting to download. Note that currently any active loads will remain open, and events may be processed.
			 * 
			 * To stop and restart a queue, use the {{#crossLink "LoadQueue/setPaused"}}{{/crossLink}} method instead.
			 
	**/
	function close():Void;
}