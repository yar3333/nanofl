package nanofl.ide.keyboard;

typedef KeymapItem = 
{
    final shortcut : String;
    final command : String;
    @:optional final when : String;
}