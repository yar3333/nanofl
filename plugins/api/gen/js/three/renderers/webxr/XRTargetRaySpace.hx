package js.three.renderers.webxr;

@:native("THREE.XRTargetRaySpace") extern class XRTargetRaySpace extends js.three.objects.Group<js.three.renderers.webxr.WebXRSpaceEventMap> {
	var hasLinearVelocity : Bool;
	var linearVelocity(default, null) : js.three.math.Vector3;
	var hasAngularVelocity : Bool;
	var angularVelocity(default, null) : js.three.math.Vector3;
}