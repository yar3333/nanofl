package nanofl.engine;

import nanofl.engine.movieclip.TweenedElement;

interface AdvancableDisplayObject
{
    function advanceTo(lifetimeOnParent:Int, element:TweenedElement #if ide , framerate:Float #end) : Void;
}