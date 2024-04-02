package nanofl.ide.draganddrop;

typedef DragInfoParams = {
	var documentId : String;
	@:optional
	var height : Float;
	@:optional
	var icon : String;
	@:optional
	var libraryItemNamePath : String;
	@:optional
	var text : String;
	@:optional
	var timelineLayerIndex : Int;
	@:optional
	var width : Float;
};