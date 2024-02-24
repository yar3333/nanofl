package nanofl.engine;

import haxe.io.Path;
import js.Browser;
import js.Syntax;
import js.lib.Promise;
import js.html.ImageElement;
import easeljs.display.SpriteSheetData;
using stdlib.Lambda;

class TextureAtlasTools
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
	
    /**
        Change URLs to images in `SpriteSheetData.images`.
    **/
    public static function resolveImages(textureAtlasesData:Array<Dynamic<SpriteSheetData>>) : Promise<{}>
    {
        if (textureAtlasesData == null) return Promise.resolve(null);

        final urlToImageStruct = new Map<String, Promise<{ url:String, image:ImageElement }>>();
        for (textureAtlasData in textureAtlasesData)
        {
            for (namePath in Reflect.fields(textureAtlasData))
            {
                final spriteSheetData : SpriteSheetData = Reflect.field(textureAtlasData, namePath);
                for (url in spriteSheetData.images)
                {
                    if (Syntax.typeof(url) == "string" && !urlToImageStruct.exists(url))
                    {
                        urlToImageStruct.set(url, resolveImage(url));
                    }
                }
            }
        }

        return Promise.all(urlToImageStruct.array()).then((data:Array<{ url:String, image:ImageElement }>) ->
        {
            final urlToImage = data.toMapOne(x -> x.url, x -> x.image);

            for (textureAtlasData in textureAtlasesData)
            {
                for (namePath in Reflect.fields(textureAtlasData))
                {
                    final spriteSheetData : SpriteSheetData = Reflect.field(textureAtlasData, namePath);
                    spriteSheetData.images = spriteSheetData.images.map(x -> urlToImage.get(x) ?? x);
                }
            }

            return null;
        });
    }

    static function resolveImage(url:String) : Promise<{ url:String, image:ImageElement }>
    {
        return Loader.javaScript(url).then(_ ->
        {
            final name = Path.withoutDirectory(Path.withoutExtension(url));
            final pngDataAsBase64 = (cast Browser.window).nanofl.textureAtlasImageFiles[cast name + ".png"];
            (cast Browser.window).nanofl.textureAtlasImageFiles[cast name + ".png"] = null;
            return Loader.image("data:image/png;base64," + pngDataAsBase64).then(image -> ({ url:url, image:image }));
        });
    }
}
