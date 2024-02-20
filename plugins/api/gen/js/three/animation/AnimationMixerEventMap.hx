package js.three.animation;

extern interface AnimationMixerEventMap {
	var loop : { var action : js.three.animation.AnimationAction; var loopDelta : Float; };
	var finished : { var action : js.three.animation.AnimationAction; var direction : Float; };
}