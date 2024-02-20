package js.three.loaders;

@:native("THREE.AudioLoader") extern class AudioLoader extends js.three.loaders.Loader<js.html.audio.AudioBuffer, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
}