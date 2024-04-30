package nanofl.ide.textureatlas;

import haxe.Json;
import haxe.DynamicAccess;
import haxe.crypto.Base64;
import nanofl.ide.library.IdeLibrary;
import nanofl.engine.ITextureItem;
import nanofl.ide.sys.FileSystem;
import easeljs.display.SpriteSheetData;
using stdlib.StringTools;
using stdlib.Lambda;

class TextureAtlasPublisher
{
    public static function publish(fileSystem:FileSystem, library:IdeLibrary, textureAtlasesParams:Map<String, TextureAtlasParams>, destDir:String, supportLocalFileOpen:Bool, framerate:Float)
    {
        var names = library.getItemsAsIde(true).filterByType(ITextureItem).map(x -> x.textureAtlas).filter(x -> !StringTools.isNullOrEmpty(x)).distinct();
        names.sort(Reflect.compare);

        var textureAtlasesData = new Array<Dynamic<SpriteSheetData>>();

        for (name in names)
        {
            log("Generate texture atlas '" + name + "'");
            
            var params = textureAtlasesParams.get(name);
            var textureAtlas = new TextureAtlasGenerator(params.width, params.height, params.padding).generate
            (
                library.getItemsAsIde(true).filter(x -> Std.isOfType(x, ITextureItem) && (cast x:ITextureItem).textureAtlas == name),
                framerate
            );

            var imageUrl = saveTextureAtlasImageAndGetUrl(fileSystem, name, textureAtlas, destDir, supportLocalFileOpen);
            textureAtlasesData.push(getTextureAtlasDataPerNamePath(fileSystem, imageUrl, textureAtlas));
        }

        log("Save 'texture-atlases.js'");
        fileSystem.saveContent(destDir + "/texture-atlases.js", "textureAtlasesData =\n" + Json.stringify(textureAtlasesData, "  "));
    }

    public static function deleteFiles(fileSystem:FileSystem, destDir:String)
    {
        fileSystem.deleteFile(destDir + "/texture-atlases.js");
        fileSystem.deleteDirectoryRecursively(destDir + "/texture-atlases");
    }
    
    static function saveTextureAtlasImageAndGetUrl(fileSystem:FileSystem, textureAtlasName:String, textureAtlas:TextureAtlas, destDir:String, supportLocalFileOpen:Bool) : String
    {
        log("Save image of texture atlas '" + textureAtlasName + "' / " + textureAtlas.imagePngAsBase64.length);

        final imageAsJsUrl = "texture-atlases/" + textureAtlasName + (supportLocalFileOpen ? ".js" : ".png");

        if (supportLocalFileOpen)
        {
            fileSystem.saveContent
            (
                destDir + "/" + imageAsJsUrl, 
                'nanofl.textureAtlasImageFiles ||= {};\n'
              + 'nanofl.textureAtlasImageFiles["' + textureAtlasName + '.png"] = "' + textureAtlas.imagePngAsBase64 + '";'
            );
        }
        else
        {
            fileSystem.saveBinary(destDir + "/" + imageAsJsUrl, Base64.decode(textureAtlas.imagePngAsBase64));
        }

        return imageAsJsUrl;
    }
        
    static function getTextureAtlasDataPerNamePath(fileSystem:FileSystem, imageUrl:String, textureAtlas:TextureAtlas) : Dynamic<SpriteSheetData>
    {
        var r : DynamicAccess<SpriteSheetData> = {};

        var namePaths = Reflect.fields(textureAtlas.itemFrames);
        for (namePath in namePaths.sorted())
        {
            r.set(namePath,
            {
                images : [ imageUrl ],
                frames : getSpriteSheetFrames(textureAtlas, namePath)
            });
        }

        return r;
    }
    
    static function getSpriteSheetFrames(textureAtlas:TextureAtlas, namePath:String) : Array<Array<Float>>
    {
        var r = new Array<Array<Float>>();
        
        var frameIndexes : Array<Int> = Reflect.field(textureAtlas.itemFrames, namePath);
        
        for (frameIndex in frameIndexes)
        {
            if (frameIndex != null)
            {
                var frame = textureAtlas.frames[frameIndex];
                r.push([ frame.x, frame.y, frame.width, frame.height, 0, frame.regX, frame.regY ]);
            }
            else
            {
                r.push([]);
            }
        }
        
        return r;
    }

	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}