package easeljs.display;

/**
 * This plugin works with <a href="http://tweenjs.com" target="_blank">TweenJS</a> to prevent the startPosition
 * property from tweening.
 */
/**
	
	 * This plugin works with <a href="http://tweenjs.com" target="_blank">TweenJS</a> to prevent the startPosition
	 * property from tweening.
	 
**/
@:native('createjs.MovieClipPlugin') extern class MovieClipPlugin {
	function new():Void;
	static var priority : Int;
	static var ID : String;
	static function install():Void;
	static function init(tween:tweenjs.Tween, prop:String, value:Dynamic):Void;
	static function step(tween:tweenjs.Tween, step:tweenjs.TweenStep, props:Dynamic):Void;
	static function change(tween:tweenjs.Tween, step:tweenjs.TweenStep, value:Dynamic, ratio:Float, end:Dynamic):Dynamic;
}