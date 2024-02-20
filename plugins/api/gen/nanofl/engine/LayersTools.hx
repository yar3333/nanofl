package nanofl.engine;

extern class LayersTools {
	static function addLayer<Layer:(TLayer)>(obj:Container<Layer>, layer:Layer):Void;
	/**
		
			 * Add block of layers into timeline.
			 * Assume that layers' parentIndex referenced inside block.
			 
	**/
	static function addLayersBlock<Layer:(TLayer)>(obj:Container<Layer>, layersToAdd:Array<Layer>, ?index:Int):Void;
	static function removeLayer<Layer:(TLayer)>(obj:Container<Layer>, index:Int):Void;
	static function removeLayerWithChildren<Layer:(TLayer)>(obj:Container<Layer>, index:Int):Array<Layer>;
	static function getFramesAt<Layer:(TLayer), Frame>(obj:ContainerRO<Layer>, frameIndex:Int):Array<Frame>;
	static function getTotalFrames<Layer:(TLayer)>(obj:ContainerRO<Layer>):Int;
}