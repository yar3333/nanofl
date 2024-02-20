package js.three.renderers.webxr;

typedef XRInputSource = Dynamic;

typedef XRHandedness = Dynamic;

extern interface WebXRSpaceEventMap extends js.three.core.Object3DEventMap {
	var select : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var selectstart : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var selectend : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var squeeze : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var squeezestart : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var squeezeend : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var connected : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var disconnected : { var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; };
	var pinchend : { var handedness : js.three.renderers.webxr.WebXRSpaceEventMap.XRHandedness; var target : js.three.renderers.webxr.WebXRController; };
	var pinchstart : { var handedness : js.three.renderers.webxr.WebXRSpaceEventMap.XRHandedness; var target : js.three.renderers.webxr.WebXRController; };
	var move : { };
}