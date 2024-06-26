package nanofl.engine;

import nanofl.engine.elements.Element;

typedef ElementLifeTrack =
{
    var sameElementSequence : Array<Element>;
    var startFrameIndex : Int;
    var lifetimeFrames : Int;
}