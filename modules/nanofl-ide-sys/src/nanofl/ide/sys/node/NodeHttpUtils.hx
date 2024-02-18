package nanofl.ide.sys.node;

import js.lib.Promise;
import nanofl.ide.sys.HttpUtils;
import nanofl.ide.sys.node.core.ElectronApi;

class NodeHttpUtils implements nanofl.ide.sys.HttpUtils
{
    public function new() {}
	
    public function requestGet(url:String, ?headers:Array<{ name:String, value:String }>) : Promise<HttpRequestResult>
	{
        return ElectronApi.http_utils.requestGet(url, headers);
    }
	
    public function requestPost(url:String, ?headers:Array<{ name:String, value:String }>, ?fields:Array<{ name:String, value:String }>, ?files:Array<{ name:String, path:String }>) : Promise<HttpRequestResult>
    {
        return ElectronApi.http_utils.requestPost(url, headers, fields, files);
    }

	public function downloadFile(url:String, destFilePath:String, ?progress:Float->Void) : Promise<Bool>
    {
        return ElectronApi.http_utils.downloadFile(url, destFilePath, progress);
    }
}
