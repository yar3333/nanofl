package js.three.loaders;

@:native("THREE.LoaderUtils") extern class LoaderUtils {
	static function decodeText(array:js.lib.BufferSource):String;
	static function extractUrlBase(url:String):String;
	static function resolveURL(url:String, path:String):String;
}