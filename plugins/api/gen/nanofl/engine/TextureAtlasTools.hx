package nanofl.engine;

extern class TextureAtlasTools {
	static function getSpriteSheet(item:nanofl.engine.ITextureItem):easeljs.display.SpriteSheet;
	/**
		
		        Change URLs to images in `SpriteSheetData.images`.
		    
	**/
	static function resolveImages(textureAtlasesData:Array<Dynamic<easeljs.display.SpriteSheetData>>):js.lib.Promise<{ }>;
}