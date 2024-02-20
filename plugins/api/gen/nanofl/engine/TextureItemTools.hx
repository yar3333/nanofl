package nanofl.engine;

extern class TextureItemTools {
	static function getSpriteSheet(item:nanofl.engine.ITextureItem):easeljs.display.SpriteSheet;
	static function preload(item:nanofl.engine.ITextureItem):js.lib.Promise<{ }>;
}