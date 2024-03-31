package nanofl.ide.draganddrop;

enum abstract DragDataType(String) from String to String
{
    var LIBRARYITEMS = "nanofl_libraryitems";
    var LAYER = "nanofl_layer";
}