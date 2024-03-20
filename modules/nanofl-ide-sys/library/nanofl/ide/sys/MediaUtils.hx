package nanofl.ide.sys;

@:rtti interface MediaUtils {
	function getVideoFileInfo(filePath:String):nanofl.ide.sys.MediaUtils.VideoFileInfo;
	function convertImage(srcFile:String, destFile:String, quality:Int):Bool;
	function convertAudio(srcFile:String, destFile:String, quality:Int):Bool;
}

typedef VideoFileInfo = {
	var durationMs : Float;
	var streams : Array<nanofl.ide.sys.MediaUtils.VideoFileStreamInfo>;
};

typedef VideoFileStreamInfo = {
	var audioChannels : Int;
	var index : Int;
	var type : String;
	var videoHeight : Int;
	var videoWidth : Int;
};