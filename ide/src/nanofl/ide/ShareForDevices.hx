package nanofl.ide;

import js.html.TextDecoder;
import haxe.Json;
import js.lib.Promise;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.HttpUtils;
import nanofl.ide.sys.Zip;
import stdlib.Uuid;
using stdlib.Lambda;

@:rtti
class ShareForDevices extends InjectContainer
{
	static inline var SERVICE_URL = "http://share.nanofl.com/";
	//static inline var SERVICE_URL = "http://logger/";
	
	@inject var preferences : Preferences;
	@inject var fileSystem : FileSystem;
	@inject var httpUtils : HttpUtils;
	@inject var zip : Zip;
	@inject var folders : Folders;
	
	public function new()
	{
		super();
		
		if (preferences.application.linkID == null || preferences.application.linkID == "")
		{
			generateNewLinkID();
		}
	}
	
	public function sendToService(dir:String) : Promise<{ statusCode:Int }>
	{
		log("sendToService " + dir);
		log("request status begin url = " + SERVICE_URL + "status/" + preferences.application.linkID + "/");
		return httpUtils.requestGet(SERVICE_URL + "status/" + preferences.application.linkID + "/").then(function(result:HttpRequestResult)
		{
			log("request status end statusCode = " + result.statusCode);
			log("request status end text = " + new TextDecoder("utf-8").decode(result.arrayBuffer));
			if (result.statusCode == 200)
			{
				return sendToServiceInner(dir, Json.parse(new TextDecoder("utf-8").decode(result.arrayBuffer)));
			}
			else if (result.statusCode == 404)
			{
				return sendToServiceInner(dir, []);
			}
			else
			{
				return Promise.resolve({ statusCode:result.statusCode });
			}
		});
	}
	
	public function generateNewLinkID() : Void
	{
		preferences.application.linkID = generateRandomString(3) + "-" + generateRandomString(3) + "-" + generateRandomString(3) + "-" + generateRandomString(3) + "-" + generateRandomString(3);
	}
	
	function sendToServiceInner(dir:String, remoteFiles:Array<{ f:String, d:Float }>) : Promise<{ statusCode:Int }>
	{
		log("remoteFiles = ");
		log(remoteFiles);
		
		log("begin find for local files");
		var files = new Array<String>();
		fileSystem.findFiles(dir, function(file) files.push(file));
		
		var localFiles = files.map(x -> { f:x.substring(dir.length + 1), d:fileSystem.getLastModified(x).getTime() });
		log("localFiles = "); log(localFiles);
		
		var filesToUpload = new Array<{ f:String, d:Float }>();
		for (localFile in localFiles)
		{
			var removeFile = remoteFiles.find(x -> x.f == localFile.f);
			if (removeFile == null || localFile.d - removeFile.d > 1000) // gap = 1s due to zip store modification time rounded to seconds
			{
				filesToUpload.push(localFile);
			}
		}
		log("filesToUpload = "); log(filesToUpload);
		
		var zipFile = folders.temp + "/" + Uuid.newUuid() + ".zip";
		zip.compress(dir, zipFile, filesToUpload.map(x -> x.f));
		
		log("zipped to " + zipFile);
		
		log("upload begin url = " + SERVICE_URL + "upload/" + preferences.application.linkID + "/");
		return httpUtils.requestPost
		(
			SERVICE_URL + "upload/" + preferences.application.linkID + "/",
			null,
			[{ name:"files", value:Json.stringify(localFiles.map(x -> x.f), "  ") }],
			[{ name:"zip", path:zipFile }]
		)
		.then(function(result:HttpRequestResult)
		{
			fileSystem.deleteFile(zipFile);
			
			log("upload end statusCode = " + result.statusCode);
			log("upload end text = " + new TextDecoder("utf-8").decode(result.arrayBuffer));
			return Promise.resolve({ statusCode:result.statusCode != 200 ? result.statusCode : 0 });
		});
	}
	
	function generateRandomString(n:Int) : String
	{
		var chars = "abcdefjhijklmnopqrstuvwxyz";
		
		var r = "";
		for (i in 0...n)
		{
			r += chars.charAt(Std.random(chars.length));
		}
		return r;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}