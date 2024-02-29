import nanofl.ide.DocumentProperties;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.ProcessManager;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.libraryitems.SoundItem;
using nanofl.ide.MovieClipItemTools;

/**
    https://ffmpeg.org/ffmpeg-filters.html#adelay
    https://ffmpeg.org/ffmpeg-filters.html#amix
    https://ffmpeg.org/ffmpeg-filters.html#aloop

    ffmpeg  -i 1.mp3 \
            -i 2.mp3 \
            -filter_complex "[1:a]adelay=12s:all=1[a1];[0:a][a1]amix=inputs=2[a]" \
            -map [a] \
            output.mp3

    ffmpeg \
        -i video1.mp4 -i audio1.mp3 \
        -c:v copy \
        -map 0:v -map 1:a \
        -y output.mp4

    ffmpeg -stream_loop 3 -i input.mp4 -c copy output.mp4


    ffmpeg -i input.mp4 -filter_complex "loop=loop=-1" output.mp4


**/
class AudioHelper
{
    public static function generateTempSoundFile(fileSystem:FileSystem, processManager:ProcessManager, folders:Folders, documentProperties:DocumentProperties, library:IdeLibrary) : String
    {
        final sounds = getSounds(documentProperties.framerate, library.getSceneItem(), library);
        if (sounds.length == 0) return null;
        
        final destFilePath = fileSystem.getTempFilePath(".ogg");
        if (!mixSounds(processManager, folders, sounds, destFilePath)) return null;
        
        return destFilePath;
    }
    
    static function mixSounds(processManager:ProcessManager, folders:Folders, sounds:Array<{ delayBeforeStartMs:Int, filePath:String  }>, destFilePath:String) : Bool
    {
        final args = [];
        
        for (sound in sounds)
        {
            args.push("-i");
            args.push(sound.filePath);
        }

        var filters = new Array<String>();
        for (i in 0...sounds.length)
        {
            filters.push("[" + i + ":a]adelay=" + sounds[i].delayBeforeStartMs + ":all=1[a" + i + "]");
            // TODO: loop
        }
        filters.push([ for (i in 0...sounds.length) "[a" + i + "]" ].join("") + "amix=inputs=" + sounds.length + "[a]");

        args.push("-filter_complex");
        args.push(filters.join(";"));

        args.push("-map");
        args.push("[a]");

        args.push(destFilePath);

        var r = processManager.runCaptured(folders.tools + "/ffmpeg.exe", args, null, null);
        return r.exitCode == 0;
    }

    static function getSounds(framerate:Float, item:MovieClipItem, library:IdeLibrary, ?r:Array<{ delayBeforeStartMs:Int, filePath:String  }>, addDelayMs=0) : Array<{ delayBeforeStartMs:Int, filePath:String  }>
    {
        if (r == null) r = new Array<{ delayBeforeStartMs:Int, filePath:String }>();

        if (item.relatedSound != null && item.relatedSound != "")
        {
            r.push({ delayBeforeStartMs:addDelayMs, filePath:(cast library.getItem(item.relatedSound) : SoundItem).getUrl() });
        }
        
        item.iterateInstances((instance, data) ->
        {
            if (Std.isOfType(instance.symbol, MovieClipItem))
            {
                final layer = item.layers[data.layerIndex];
                var frameCount = 0;
                for (i in 0...data.keyFrameIndex)
                {
                    frameCount += layer.keyFrames[i].duration;
                }
                final delayMs = addDelayMs + Math.round(frameCount * (1.0 / framerate));
                getSounds(framerate, (cast instance.symbol : MovieClipItem), library, r, delayMs);
            }
        });

        return r;
    }
}