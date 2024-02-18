package js.three.loaders;

@:native("THREE.FileLoader") extern class FileLoader extends js.three.loaders.Loader<haxe.extern.EitherType<String, js.lib.ArrayBuffer>, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	var mimeType : haxe.extern.EitherType<{ }, js.html.MimeType>;
	var responseType : haxe.extern.EitherType<{ }, String>;
	override function load(url:String, ?onLoad:haxe.extern.EitherType<String, js.lib.ArrayBuffer> -> Void, ?onProgress:js.html.ProgressEvent -> Void, ?onError:Dynamic -> Void):Void;
	function setMimeType(mimeType:js.html.MimeType):js.three.loaders.FileLoader;
	function setResponseType(responseType:String):js.three.loaders.FileLoader;
}