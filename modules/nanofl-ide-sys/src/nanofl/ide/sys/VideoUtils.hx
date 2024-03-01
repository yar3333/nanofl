package nanofl.ide.sys;

@:rtti
interface VideoUtils
{
    function getFileInfo(filePath:String) : VideoFileInfo;
}

typedef VideoFileInfo =
{
    var durationMs : Float;
    var streams : Array<VideoFileStreamInfo>;
}

typedef VideoFileStreamInfo =
{
    var index : Int;
    var type : String;
    var videoWidth : Int;
    var videoHeight : Int;
    var audioChannels : Int;
}
