package nanofl;

typedef SpriteParams = {
	@:optional
	var currentFrame : Int;
};

extern class Sprite extends easeljs.display.Sprite implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.ISpritableItem, params:nanofl.Sprite.SpriteParams):Void;
	function advanceToNextFrame():Void;
	function advanceTo(advanceFrames:Int, framerate:Float, tweenedElement:nanofl.engine.movieclip.TweenedElement):Void;
}