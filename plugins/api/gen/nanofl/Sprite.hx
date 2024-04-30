package nanofl;

typedef SpriteParams = {
	@:optional
	var currentFrame : Int;
};

extern class Sprite extends easeljs.display.Sprite implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.ISpritableItem, params:nanofl.Sprite.SpriteParams):Void;
	function advanceTo(lifetimeOnParent:Int, tweenedElement:nanofl.engine.movieclip.TweenedElement, framerate:Float):Void;
}