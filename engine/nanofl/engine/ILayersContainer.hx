package nanofl.engine;

import datatools.ArrayRO;
import nanofl.engine.movieclip.Layer;

interface ILayersContainer
{
	var layers(get, never) : ArrayRO<Layer>;
	function get_layers(): ArrayRO<Layer>;
	
  	function toString() : String;
}