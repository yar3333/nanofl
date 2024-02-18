package nanofl.engine;

interface ITimeline {
	function addLayer(layer:nanofl.engine.movieclip.Layer):Void;
	function addLayersBlock(layersToAdd:Array<nanofl.engine.movieclip.Layer>, ?index:Int):Void;
	function removeLayer(index:Int):Void;
	function removeLayerWithChildren(index:Int):Array<nanofl.engine.movieclip.Layer>;
}