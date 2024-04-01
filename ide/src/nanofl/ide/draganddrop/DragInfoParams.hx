package nanofl.ide.draganddrop;

typedef DragInfoParams =
{
    var documentId : String;
    
    // if one library item dragged
    @:optional var libraryItemNamePath : String;

    // if one timeline layer dragged
    @:optional var timelineLayerIndex : Int;

    // for DragImageType.ICON_AND_TEXT
    @:optional var icon : String;
    @:optional var text : String;

    // for DragImageType.RECTANGLE
    @:optional var width : Float;
    @:optional var height : Float;
}