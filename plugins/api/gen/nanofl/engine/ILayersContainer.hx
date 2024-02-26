package nanofl.engine;

interface ILayersContainer {
	var layers(get, never) : Array<nanofl.engine.movieclip.Layer>;
	function get_layers():Array<nanofl.engine.movieclip.Layer>;
	function toString():String;
}