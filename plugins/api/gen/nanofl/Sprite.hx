package nanofl;

extern class Sprite extends easeljs.display.Sprite implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.ISpritableItem):Void;
	override function advance(?time:Float):Void;
	function advanceTo(advanceFrames:Int):Void;
}