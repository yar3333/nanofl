package nanofl.engine;

typedef ElementLifeTrack = {
	var lifetimeFrames : Int;
	var sameElementSequence : Array<nanofl.engine.elements.Element>;
	var startFrameIndex : Int;
};