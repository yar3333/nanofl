package nanofl.ide;

import nanofl.engine.movieclip.TweenedElement;

interface IdeAdvancableDisplayObject
{
    function advanceTo(advanceFrames:Int, framerate:Float, element:TweenedElement) : Void;
}