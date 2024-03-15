package nanofl.ide.sys.node;

import haxe.Json;
import nanofl.ide.sys.VideoUtils;

class NodeVideoUtils implements VideoUtils
{
    final processManager : ProcessManager;
    final folders : Folders;

    public function new(processManager:ProcessManager, folders:Folders)
    {
        this.processManager = processManager;
        this.folders = folders;
    }

    public function getFileInfo(filePath:String) : VideoFileInfo
    {
        final r = processManager.runCaptured(folders.tools + "/ffprobe.exe", [ "-v", "quiet", "-print_format", "json", "-show_format", "-show_streams", filePath ]);
        if (r.code != 0) return null;
        
        final info : FFprobeVideoFileInfo = Json.parse(r.out);
        
        return
        {
            durationMs: Std.parseFloat(info.format.duration) * 1000,
            streams: info.streams.map(x ->
            ({ 
                index: x.index, 
                type: x.codec_type, 
                videoWidth: x.width, 
                videoHeight: x.height, 
                audioChannels: x.channels,
            }))
        };
    }
}

typedef FFprobeVideoFileInfo =
{
    var streams : Array<FFprobeVideoFileVideoStreamInfo & FFprobeVideoFileAudioStreamInfo>;
    var format : FFprobeVideoFileFormat;
}

typedef FFprobeVideoFileBaseVideoStreamInfo =
{
    var index : Int; // 0
    var codec_name : String; // "h264", "aac"
    var codec_long_name : String; // "H.264 / AVC / MPEG-4 AVC / MPEG-4 part 10", "AAC (Advanced Audio Coding)"
    var profile : String; // "High", "LC"
    var codec_type : String; // "video", "audio"
    var codec_tag_string : String; // "avc1", "mp4a"
    var codec_tag : String; // "0x31637661", "0x6134706d"

    var id : String; // "0x1"
    var r_frame_rate : String; // "30/1"
    var avg_frame_rate : String; // "4950000/164981"
    var time_base : String; // "1/90000"
    var start_pts : Int; // 0
    var start_time : String; // "0.000000"
    var duration_ts : Int; // 2804677
    var duration : String; // "31.163078"
    var bit_rate : String; // "17039676"
    var nb_frames : String; // "935"
    var extradata_size : Int; // 26
    var disposition : FFprobeVideoFileStreamDispositionInfo;
    var tags : Dynamic<String>;
        // "creation_time": "2017-10-08T12:03:28.000000Z",
        // "language": "eng",
        // "handler_name": "VideoHandle",
        // "vendor_id": "[0][0][0][0]"

    // var id : String; // "0x2"
    // var r_frame_rate : String; // "0/0"
    // var avg_frame_rate : String; // "0/0"
    // var time_base : String; // "1/48000"
    // var start_pts : Int; // 0
    // var start_time : String; // "0.000000"
    // var duration_ts : Int; // 1496064
    // var duration : String; // "31.168000"
    // var bit_rate : String; // "256016"
    // var nb_frames : String; // "1461"
    // var extradata_size : Int; // 2
    // var disposition : VideoFileStreamDispositionInfo;
    // var tags : Dynamic<String>;
        // "creation_time": "2017-10-08T12:03:28.000000Z"
        // "language": "eng"
        // "handler_name": "SoundHandle"
        // "vendor_id": "[0][0][0][0]"


}

typedef FFprobeVideoFileVideoStreamInfo =
{>FFprobeVideoFileBaseVideoStreamInfo,
    var width : Int; // 1920
    var height : Int; // 1080
    var coded_width : Int; // 1920
    var coded_height : Int; // 1080
    var closed_captions : Int; // 0
    var film_grain : Int; // 0
    var has_b_frames : Int; // 0
    var sample_aspect_ratio : String; // "1:1"
    var display_aspect_ratio : String; // "16:9"
    var pix_fmt : String; // "yuv420p"
    var level : Int; // 40
    var color_range : String; // "tv"
    var color_space : String; // "bt709"
    var color_transfer : String; // "bt709"
    var color_primaries : String; // "bt709"
    var field_order : String; // "progressive"
    var refs : Int; // 1
    var is_avc : String; // "true"
    var nal_length_size : String; // "4"
    var bits_per_raw_sample : String; // "8"
    var side_data_list : Array<FFprobeVideoStreamSideData>;
}

typedef FFprobeVideoFileAudioStreamInfo =
{>FFprobeVideoFileBaseVideoStreamInfo,
    var sample_fmt : String; // "fltp"
    var sample_rate : String; // "48000"
    var channels : Int; // 2
    var channel_layout : String; // "stereo"
    var bits_per_sample : Int; // 0
    var initial_padding : Int; // 0
}

typedef FFprobeVideoFileStreamDispositionInfo =
{
    @:native("default")
    var default_ : Int; // 1
    var dub : Int; // 0
    var original : Int; // 0
    var comment : Int; // 0
    var lyrics : Int; // 0
    var karaoke : Int; // 0
    var forced : Int; // 0
    var hearing_impaired : Int; // 0
    var visual_impaired : Int; // 0
    var clean_effects : Int; // 0
    var attached_pic : Int; // 0
    var timed_thumbnails : Int; // 0
    var non_diegetic : Int; // 0
    var captions : Int; // 0
    var descriptions : Int; // 0
    var metadata : Int; // 0
    var dependent : Int; // 0
    var still_image : Int; // 0
}

typedef FFprobeVideoFileFormat = 
{
    //var filename : String; // "d:\\Video\\_╨║╨▓╨░╨┤╤А╨╛╨║╨╛╨┐╤В╨╡╤А\\20171008_150256.mp4"
    var nb_streams : Int; // 2
    var nb_programs : Int; // 0
    var format_name : String; // "mov,mp4,m4a,3gp,3g2,mj2"
    var format_long_name : String; // "QuickTime / MOV"
    var start_time : String; // "0.000000"
    var duration : String; // "31.168000"
    var size : String; // "67391145"
    var bit_rate : String; // "17297521"
    var probe_score : Int; // 100
    var tags : Dynamic<String>;
        // "major_brand": "mp42"
        // "minor_version": "0"
        // "compatible_brands": "isommp42"
        // "creation_time": "2017-10-08T12:03:28.000000Z"
        // "location": "+53.3411+034.2253/"
        // "location-eng": "+53.3411+034.2253/"
        // "com.android.version": "7.0"
}

typedef FFprobeVideoStreamSideData =
{
    var side_data_type : String; // "Display Matrix"
    var displaymatrix : String; // "\n00000000:            0       65536           0\n00000001:       -65536     0           0\n00000002:            0           0  1073741824\n"
    var rotation : Int; // -90
}
