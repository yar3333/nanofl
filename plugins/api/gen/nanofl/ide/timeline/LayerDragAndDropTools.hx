package nanofl.ide.timeline;

extern class LayerDragAndDropTools {
	static function getDragImageType(type:nanofl.ide.draganddrop.DragDataType, params:nanofl.ide.draganddrop.DragInfoParams):nanofl.ide.draganddrop.DragImageType;
	static function moveLayer(document:nanofl.ide.Document, timeline:nanofl.ide.timeline.ITimelineView, srcLayerIndex:Int, destLayerIndex:Int):Void;
}