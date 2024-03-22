package nanofl.engine;

import nanofl.engine.movieclip.TweenedElement;

interface AdvancableDisplayObject
{
    function advanceToNextFrame() : Void;

    #if ide
    function advanceTo(advanceFrames:Int, framerate:Float, element:TweenedElement) : Void;
    #end
}