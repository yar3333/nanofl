package js.three.renderers.webxr;

@:native("THREE.XRJointSpace") extern class XRJointSpace extends js.three.objects.Group<js.three.core.Object3DEventMap> {
	var jointRadius(default, null) : haxe.extern.EitherType<Float, { }>;
}