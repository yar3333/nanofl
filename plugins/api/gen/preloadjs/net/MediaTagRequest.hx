package preloadjs.net;

/**
 * An {{#crossLink "TagRequest"}}{{/crossLink}} that loads HTML tags for video and audio.
 */
/**
	
	 * An {{#crossLink "TagRequest"}}{{/crossLink}} that loads HTML tags for video and audio.
	 
**/
@:native('createjs.MediaTagRequest') extern class MediaTagRequest extends preloadjs.net.TagRequest {
	function new(loadItem:preloadjs.data.LoadItem, tag:haxe.extern.EitherType<js.html.AudioElement, js.html.VideoElement>, srcAttribute:String):Void;
}