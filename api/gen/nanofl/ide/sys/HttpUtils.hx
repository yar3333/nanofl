package nanofl.ide.sys;

interface HttpUtils {
	function requestGet(url:String, ?headers:Array<{ public var value(default, default) : String; public var name(default, default) : String; }>):js.lib.Promise<nanofl.ide.sys.HttpUtils.HttpRequestResult>;
	function requestPost(url:String, ?headers:Array<{ public var value(default, default) : String; public var name(default, default) : String; }>, ?fields:Array<{ public var value(default, default) : String; public var name(default, default) : String; }>, ?files:Array<{ public var path(default, default) : String; public var name(default, default) : String; }>):js.lib.Promise<nanofl.ide.sys.HttpUtils.HttpRequestResult>;
	function downloadFile(url:String, destFilePath:String, ?progress:Float -> Void):js.lib.Promise<Bool>;
}

typedef HttpRequestResult = {
	var arrayBuffer : js.lib.ArrayBuffer;
	var statusCode : Int;
};