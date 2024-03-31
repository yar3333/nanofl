package nanofl.ide.draganddrop;

enum abstract DragDataType(String) from String to String
{
    var DDT_LIBRARYITEMS = "nanofl_libraryitems";
    var DDT_LAYER = "nanofl_layer";
}