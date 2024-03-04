import nanofl.engine.movieclip.Layer;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.ide.libraryitems.VideoItem;
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
    static final MAX_DURATION = 2000000000;

    public static function getFFmpegArgsForMixTracks(tracks:Array<AudioTrack>, startInputIndex:Int) : Array<String>
    {
        final args = [];
        if (tracks.length == 0) return args;
        
        for (tracks in tracks)
        {
            if (tracks.durationMs != null)
            {
                if (tracks.loop) args.push("-stream_loop"); args.push("-1");
                if (tracks.durationMs != null) args.push("-t"); args.push(tracks.durationMs + "ms");
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
        return getMovieClipTracksInner(framerate, library.getSceneItem(), library, new Array<AudioTrack>(), 0, MAX_DURATION);
    }

    static function getMovieClipTracksInner(framerate:Float, item:MovieClipItem, library:IdeLibrary, r:Array<AudioTrack>, addDelayMs:Int, mcLivingMs:Int) : Array<AudioTrack>
    {
        if (item.relatedSound != null && item.relatedSound != "")
        {
            final mcSound : SoundItem = cast library.getItem(item.relatedSound);
            r.push
            ({
                delayBeforeStartMs: addDelayMs, 
                filePath: library.libraryDir + "/" + mcSound.namePath + "." + mcSound.ext,
                loop: mcSound.loop,
                durationMs: mcSound.loop ? Math.round(item.getTotalFrames() / framerate) : null, // TODO: improve loop duration, kill sound on mc remove, detect between-keyframes mc keeping
            });
        }
        
        item.iterateInstances((instance, data) ->
        {
            if (Std.isOfType(instance.symbol, MovieClipItem) || Std.isOfType(instance.symbol, VideoItem))
            {
                final layer = item.layers[data.layerIndex];
                final delayMs = Math.round(getFrameCoundBeforeKeyFrame(layer, data.keyFrameIndex) / framerate);
                final maxInnerLivingFrames = getItemsMaxLivingFrames(item, layer, data.keyFrameIndex);
                final maxInnerLivingMs = maxInnerLivingFrames < MAX_DURATION 
                            ? Math.round(Math.min(mcLivingMs - delayMs, maxInnerLivingFrames / framerate))
                            : MAX_DURATION;
                
                if (Std.isOfType(instance.symbol, MovieClipItem))
                {
                    getMovieClipTracksInner(framerate, (cast instance.symbol : MovieClipItem), library, r, addDelayMs + delayMs, maxInnerLivingMs);
                }
                else if (Std.isOfType(instance.symbol, VideoItem))
                {
                    final mcVideo : VideoItem = cast library.getItem(item.relatedSound);
                    r.push
                    ({
                        delayBeforeStartMs: addDelayMs + delayMs, 
                        filePath: library.libraryDir + "/" + mcVideo.namePath + "." + mcVideo.ext,
                        loop: mcVideo.loop,
                        durationMs: maxInnerLivingMs, // TODO: improve loop duration, kill sound on mc remove, detect between-keyframes mc keeping
                    });
                }
            }
        });

        return r;
    }

    static function getFrameCoundBeforeKeyFrame(layer:Layer, keyFrameIndex:Int) : Int
    {
        var r = 0; 
        for (i in 0...keyFrameIndex)
        {
            r += layer.keyFrames[i].duration;
        }
        return r;
    }

    static function getItemsMaxLivingFrames(item:MovieClipItem, layer:Layer, keyFrameIndex:Int) : Int
    {
        final keyFrame = layer.keyFrames[keyFrameIndex];
        if (keyFrameIndex < layer.keyFrames.length - 1) return keyFrame.duration;
        if (getFrameCoundBeforeKeyFrame(layer, keyFrameIndex) + keyFrame.duration < item.getTotalFrames()) return keyFrame.duration;
        return MAX_DURATION; // keyframe's items live at end of timeline => don't limited duration
    }
}