package nanofl;

extern class Sprite extends easeljs.display.Sprite implements nanofl.engine.AdvancableDisplayObject {
	function new(spriteSheet:easeljs.display.SpriteSheet, ?frameOrAnimation:Dynamic):Void;
	function advance():js.lib.Promise<{ }>;
}