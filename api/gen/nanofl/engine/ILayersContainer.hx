package nanofl.engine;

interface ILayersContainer {
	var layers(get, never) : datatools.ArrayRO<nanofl.engine.movieclip.Layer>;
	function get_layers():datatools.ArrayRO<nanofl.engine.movieclip.Layer>;
	function toString():String;
}