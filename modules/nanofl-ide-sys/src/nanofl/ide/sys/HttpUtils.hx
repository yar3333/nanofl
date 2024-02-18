package nanofl.ide.sys;

@:rtti
interface HttpUtils
{
	function requestGet(url:String, ?headers:Array<{ name:String, value:String }>) : js.lib.Promise<HttpRequestResult>;
	function requestPost(url:String, ?headers:Array<{ name:String, value:String }>, ?fields:Array<{ name:String, value:String }>, ?files:Array<{ name:String, path:String }>) : js.lib.Promise<HttpRequestResult>;
	function downloadFile(url:String, destFilePath:String, ?progress:Float->Void) : js.lib.Promise<Bool>;
}

typedef HttpRequestResult =
{
	var statusCode : Int;
	var arrayBuffer : js.lib.ArrayBuffer;
}
