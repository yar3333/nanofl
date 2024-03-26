import nanofl.engine.ElementType;
import nanofl.engine.LibraryItemType;
import nanofl.engine.elements.Instance;
import nanofl.ide.ElementLifeTrack;
import nanofl.ide.ElementLifeTracker;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.ide.libraryitems.VideoItem;
using nanofl.ide.MovieClipItemTools;
using Lambda;

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
        
        for (track in tracks)
        {
            if (track.duration != null)
            {
                if (track.loop) args.push("-stream_loop"); args.push("-1");
                if (track.seekTo != 0) args.push("-ss"); args.push(track.seekTo + "");
                if (track.duration != null) args.push("-t"); args.push(track.duration + "");
            }
            args.push("-i"); args.push(track.filePath);
        }

        var filters = new Array<String>();
        for (i in 0...tracks.length)
        {
            filters.push("[" + (i + startInputIndex) + ":a]adelay=" + tracks[i].delayBeforeStart + "s:all=1[a" + i + "]");
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
            r.push(createAudioTrack(mcSound, track, framerate, library, 0));
        }

        final trackVideos = tracker.tracks.filter(x -> x.sameElementSequence[0].type.match(ElementType.instance)
                                              && (cast x.sameElementSequence[0] : Instance).symbol.type.match(LibraryItemType.video)
                                              && getVideoItemFromTrack(x).hasAudio
                                              && !isInstanceTweened((cast x.sameElementSequence[0] : Instance)));
        for (track in trackVideos)
        {
            final mcVideo = getVideoItemFromTrack(track);
            final audioTrack = createAudioTrack(mcVideo, track, framerate, library, (cast track.sameElementSequence[0] : Instance).videoCurrentTime ?? 0);
            
            r.push(audioTrack);
            
            //trace("trackVideo: startFrameIndex = " + track.startFrameIndex + "; lifetimeFrames = " + track.lifetimeFrames);
            //trace("trackAudio: delayBeforeStart = " + audioTrack.delayBeforeStart + "; duration = " + audioTrack.duration);
        }

        return r;
    }

    static function createAudioTrack(item:{ namePath:String, ext:String, loop:Bool }, track:ElementLifeTrack, framerate:Float, library:IdeLibrary, seekTo:Float) : AudioTrack
    {
        return
        {
            delayBeforeStart: track.startFrameIndex / framerate,
            filePath: library.libraryDir + "/" + item.namePath + "." + item.ext,
            loop: item.loop,
            seekTo: seekTo,
            duration: item.loop ? track.lifetimeFrames / framerate : null,
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

    static function isInstanceTweened(instance:Instance) : Bool
    {
        // if (!instance.parent.hasMotionTween()) return false;
        // final instancesMap = instance.parent.getMotionTween().getInstancesMap();
        // if (!instancesMap.has(instance)) return false;
        // return instancesMap.get(instance) != instance;
        return instance.parent.hasMotionTween() || instance.parent.duration == 1 && (instance.parent.getPrevKeyFrame()?.hasMotionTween() ?? false);
    }
}