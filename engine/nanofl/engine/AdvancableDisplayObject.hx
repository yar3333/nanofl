package nanofl.engine;

interface AdvancableDisplayObject
{
    function advanceToNextFrame() : Void;

    #if ide
    function advanceTo(advanceFrames:Int, framerate:Float) : Void;
    #end
}