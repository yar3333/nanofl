package nanofl.ide.sys;

@:rtti
interface MediaUtils
{
    function getVideoFileInfo(filePath:String) : VideoFileInfo;
	function convertImage(srcFile:String, destFile:String, quality:Int) : Bool;
	function convertAudio(srcFile:String, destFile:String, quality:Int) : Bool;
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
