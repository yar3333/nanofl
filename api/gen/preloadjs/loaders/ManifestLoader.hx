package preloadjs.loaders;

/**
 * A loader for JSON manifests. Items inside the manifest are loaded before the loader completes. To load manifests
 * using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}} as part of the
 * {{#crossLink "LoadItem"}}{{/crossLink}}.
 *
 * The list of files in the manifest must be defined on the top-level JSON object in a `manifest` property. This
 * example shows a sample manifest definition, as well as how to to include a sub-manifest.
 *
 * 		{
 * 			"path": "assets/",
 * 	 	    "manifest": [
 * 				"image.png",
 * 				{"src": "image2.png", "id":"image2"},
 * 				{"src": "sub-manifest.json", "type":"manifest", "callback":"jsonCallback"}
 * 	 	    ]
 * 	 	}
 *
 * When a ManifestLoader has completed loading, the parent loader (usually a {{#crossLink "LoadQueue"}}{{/crossLink}},
 * but could also be another ManifestLoader) will inherit all the loaded items, so you can access them directly.
 *
 * Note that the {{#crossLink "JSONLoader"}}{{/crossLink}} and {{#crossLink "JSONPLoader"}}{{/crossLink}} are
 * higher priority loaders, so manifests <strong>must</strong> set the {{#crossLink "LoadItem"}}{{/crossLink}}
 * {{#crossLink "LoadItem/type:property"}}{{/crossLink}} property to {{#crossLink "Types/MANIFEST:property"}}{{/crossLink}}.
 *
 * Additionally, some browsers require the server to serve a JavaScript mime-type for JSONP, so it may not work in
 * some conditions.
 */
/**
	
	 * A loader for JSON manifests. Items inside the manifest are loaded before the loader completes. To load manifests
	 * using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}} as part of the
	 * {{#crossLink "LoadItem"}}{{/crossLink}}.
	 * 
	 * The list of files in the manifest must be defined on the top-level JSON object in a `manifest` property. This
	 * example shows a sample manifest definition, as well as how to to include a sub-manifest.
	 * 
	 * 		{
	 * 			"path": "assets/",
	 * 	 	    "manifest": [
	 * 				"image.png",
	 * 				{"src": "image2.png", "id":"image2"},
	 * 				{"src": "sub-manifest.json", "type":"manifest", "callback":"jsonCallback"}
	 * 	 	    ]
	 * 	 	}
	 * 
	 * When a ManifestLoader has completed loading, the parent loader (usually a {{#crossLink "LoadQueue"}}{{/crossLink}},
	 * but could also be another ManifestLoader) will inherit all the loaded items, so you can access them directly.
	 * 
	 * Note that the {{#crossLink "JSONLoader"}}{{/crossLink}} and {{#crossLink "JSONPLoader"}}{{/crossLink}} are
	 * higher priority loaders, so manifests <strong>must</strong> set the {{#crossLink "LoadItem"}}{{/crossLink}}
	 * {{#crossLink "LoadItem/type:property"}}{{/crossLink}} property to {{#crossLink "Types/MANIFEST:property"}}{{/crossLink}}.
	 * 
	 * Additionally, some browsers require the server to serve a JavaScript mime-type for JSONP, so it may not work in
	 * some conditions.
	 
**/
@:native('createjs.ManifestLoader') extern class ManifestLoader extends preloadjs.loaders.AbstractLoader {
	function new(loadItem:Dynamic):Void;
	/**
		
			 * Determines if the loader can load a specific item. This loader can only load items that are of type
			 * {{#crossLink "Types/MANIFEST:property"}}{{/crossLink}}
			 
	**/
	static function canLoadItem(item:Dynamic):Bool;
}