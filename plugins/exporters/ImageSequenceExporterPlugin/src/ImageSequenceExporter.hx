import js.lib.Promise;
import haxe.Timer;
import haxe.io.Path;
import haxe.crypto.Base64;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.sys.FileSystem;
using StringTools;

class ImageSequenceExporter
{
	public static function run(type:String, applyBackgroundColor:Bool, fileSystem:FileSystem, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Promise<Bool>
	{
		var totalFrames = library.getSceneItem().getTotalFrames();
		var digits = Std.string(totalFrames - 1).length;
		
		var baseDestFilePath = Path.withoutExtension(destFilePath) + "_";
		var ext = "." + Path.extension(destFilePath);

        var sceneFramesIterator = library.getSceneFramesIterator(documentProperties, applyBackgroundColor);

        return new Promise<Bool>((resolve, reject) ->
        {
            var i = 0;

            function generateNextImageFile()
            {
                if (!sceneFramesIterator.hasNext()) { resolve(true); return; }
                sceneFramesIterator.next().then(ctx ->
                {
                    var data = ctx.canvas.toDataURL(type).split(",")[1];
                    fileSystem.saveBinary(baseDestFilePath + Std.string(i++).lpad("0", digits) + ext, Base64.decode(data));
                    Timer.delay(() -> generateNextImageFile(), 0);
                });
            }

            generateNextImageFile();
        });
	}
}