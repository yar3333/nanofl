package nanofl.ide.sys;

interface VideoUtils {
	function getFileInfo(filePath:String):nanofl.ide.sys.VideoUtils.VideoFileInfo;
}

typedef VideoFileInfo = {
	var durationMs : Float;
	var streams : Array<nanofl.ide.sys.VideoUtils.VideoFileStreamInfo>;
};

typedef VideoFileStreamInfo = {
	var audioChannels : Int;
	var index : Int;
	var type : String;
	var videoHeight : Int;
	var videoWidth : Int;
};