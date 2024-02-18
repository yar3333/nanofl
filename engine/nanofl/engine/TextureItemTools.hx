package nanofl.engine;

import js.lib.Promise;

class TextureItemTools
{
	public static function getSpriteSheet(item:ITextureItem) : easeljs.display.SpriteSheet
	{
        #if ide
		return null;
        #else
		return item.textureAtlas != null && item.textureAtlas != "" && Reflect.hasField(nanofl.Player.spriteSheets, item.namePath)
			? Reflect.field(nanofl.Player.spriteSheets, item.namePath)
			: null;
        #end
	}
	
	public static function preload(item:ITextureItem) : Promise<{}>
	{
		var spriteSheet = getSpriteSheet(item);
		if (spriteSheet != null)
		{
			return spriteSheet.complete 
					? Promise.resolve()
					: new Promise<{}>((resolve, reject) -> spriteSheet.addCompleteEventListener(_ -> resolve(null)));
		}
		else
		{
			return Promise.resolve();
		}
	}
}
