package nanofl.engine;

interface AdvancableDisplayObject
{
    /**
        `time` is ignored.
    **/
    function advance(?time:Float) : Void;

    #if ide
    function advanceTo(advanceFrames:Int) : Void;
    #end
}