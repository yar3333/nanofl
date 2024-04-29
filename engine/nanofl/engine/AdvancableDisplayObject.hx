package nanofl.engine;

import nanofl.engine.movieclip.TweenedElement;

interface AdvancableDisplayObject
{
    function advanceTo(lifetimeOnParent:Int, framerate:Float, element:TweenedElement) : Void;
}