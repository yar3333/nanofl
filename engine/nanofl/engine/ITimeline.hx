package nanofl.engine;

import nanofl.engine.movieclip.Layer;

interface ITimeline
{
	function addLayer(layer:Layer) : Void;
	function addLayersBlock(layersToAdd:Array<Layer>, ?index:Int) : Void;
	function removeLayer(index:Int) : Void;
	function removeLayerWithChildren(index:Int) : Array<Layer>;
}