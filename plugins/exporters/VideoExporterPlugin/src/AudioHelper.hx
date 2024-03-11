import nanofl.engine.ElementType;
import nanofl.engine.LibraryItemType;
import nanofl.engine.elements.Instance;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.ElementLifeTracker;
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
        final tracker = ElementLifeTracker.createForMovieClip(library.getSceneItem(), true);
        
        final r = new Array<AudioTrack>();
        
        final trackMovieClips = tracker.tracks.filter(x -> x.sameElementSequence[0].type.match(ElementType.instance)
                                                  && (cast x.sameElementSequence[0] : Instance).symbol.type.match(LibraryItemType.movieclip)
                                                  && getMovieClipItemFromTrack(x).relatedSound != null
                                                  && getMovieClipItemFromTrack(x).relatedSound != "");
        for (track in trackMovieClips)
        {
            final item = getMovieClipItemFromTrack(track);
            final mcSound : SoundItem = cast library.getItem(item.relatedSound);
            r.push(createAudioTrack(mcSound, track, framerate, library));
        }

        final trackVideos = tracker.tracks.filter(x -> x.sameElementSequence[0].type.match(ElementType.instance)
                                              && (cast x.sameElementSequence[0] : Instance).symbol.type.match(LibraryItemType.video)
                                              // && getVideoItemFromTrack(x) // TODO: check video has audio
        );
        for (track in trackVideos)
        {
            final mcVideo = getVideoItemFromTrack(track);
            r.push(createAudioTrack(mcVideo, track, framerate, library));
        }

        return r;
    }

    static function createAudioTrack(item:{ namePath:String, ext:String, loop:Bool }, track:ElementLifeTrack, framerate:Float, library:IdeLibrary) : AudioTrack
    {
        return {
            delayBeforeStartMs: Math.floor(track.startFrameIndex / framerate),
            filePath: library.libraryDir + "/" + item.namePath + "." + item.ext,
            loop: item.loop,
            durationMs: item.loop ? Math.round(track.lifetimeFrames / framerate) : null,
        };
    }

    static function getMovieClipItemFromTrack(track:ElementLifeTrack) : MovieClipItem
    {
        final element = track.sameElementSequence[0];
        final instance : Instance = cast element;
        return (cast instance.symbol : MovieClipItem);
    }

    static function getVideoItemFromTrack(track:ElementLifeTrack) : VideoItem
    {
        final element = track.sameElementSequence[0];
        final instance : Instance = cast element;
        return (cast instance.symbol : VideoItem);
    }
}