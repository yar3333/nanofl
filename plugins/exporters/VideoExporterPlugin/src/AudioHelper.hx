import nanofl.ide.library.IdeLibrary;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.libraryitems.SoundItem;
using nanofl.ide.MovieClipItemTools;

/**
    https://ffmpeg.org/ffmpeg-filters.html#adelay
    https://ffmpeg.org/ffmpeg-filters.html#amix

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

    ffmpeg \
        -stream_loop -1 \   // infinite loop (used before -i)
        -t 10000ms \        // duration limit (used before -i)
        -i input.mp4 -c copy output.mp4
**/
class AudioHelper
{
    public static function getFFmpegArgsForMixTracks(tracks:Array<AudioTrack>, startInputIndex:Int) : Array<String>
    {
        final args = [];
        if (tracks.length == 0) return args;
        
        for (tracks in tracks)
        {
            if (tracks.loopDurationMs != null)
            {
                args.push("-stream_loop"); args.push("-1");
                args.push("-t"); args.push(tracks.loopDurationMs + "ms");
            }
            args.push("-i"); args.push(tracks.filePath);
        }

        var filters = new Array<String>();
        for (i in 0...tracks.length)
        {
            filters.push("[" + (i + startInputIndex) + ":a]adelay=" + tracks[i].delayBeforeStartMs + ":all=1[a" + i + "]");
        }
        filters.push([ for (i in 0...tracks.length) "[a" + i + "]" ].join("") + "amix=inputs=" + tracks.length + "[a]");

        args.push("-filter_complex"); args.push(filters.join(";"));

        args.push("-map"); args.push("[a]");

        return args;
    }

    public static function getSceneTracks(framerate:Float, library:IdeLibrary) : Array<AudioTrack>
    {
        return getMovieClipTracksInner(framerate, library.getSceneItem(), library, new Array<AudioTrack>(), 0);
    }

    static function getMovieClipTracksInner(framerate:Float, item:MovieClipItem, library:IdeLibrary, r:Array<AudioTrack>, addDelayMs:Int) : Array<AudioTrack>
    {
        if (item.relatedSound != null && item.relatedSound != "")
        {
            final mcSound : SoundItem = cast library.getItem(item.relatedSound);
            r.push
            ({
                delayBeforeStartMs: addDelayMs, 
                filePath: library.libraryDir + "/" + mcSound.namePath + "." + mcSound.ext,
                loopDurationMs: mcSound.loop ? Math.round(item.getTotalFrames() / framerate) : null
            });
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
                final delayMs = addDelayMs + Math.round(frameCount / framerate);
                getMovieClipTracksInner(framerate, (cast instance.symbol : MovieClipItem), library, r, delayMs);
            }
        });

        return r;
    }

    static function getUrl() {
        
    }
}