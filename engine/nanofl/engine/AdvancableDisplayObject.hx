package nanofl.engine;

interface AdvancableDisplayObject
{
    function advanceToNextFrame(#if ide framerate:Float #end) : Void;

    #if ide
    function advanceTo(advanceFrames:Int) : Void;
    #end
}