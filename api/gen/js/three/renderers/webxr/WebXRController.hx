package js.three.renderers.webxr;

typedef XRHandSpace = Dynamic;

typedef XRControllerEventType = Dynamic;

typedef XRFrame = Dynamic;

typedef XRReferenceSpace = Dynamic;

@:native("THREE.WebXRController") extern class WebXRController {
	function new():Void;
	function getHandSpace():js.three.renderers.webxr.WebXRController.XRHandSpace;
	function getTargetRaySpace():js.three.renderers.webxr.XRTargetRaySpace;
	function getGripSpace():js.three.renderers.webxr.XRGripSpace;
	function dispatchEvent(event:{ @:optional
	var data : js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource; var type : js.three.renderers.webxr.WebXRController.XRControllerEventType; }):js.three.renderers.webxr.WebXRController;
	function connect(inputSource:js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource):js.three.renderers.webxr.WebXRController;
	function disconnect(inputSource:js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource):js.three.renderers.webxr.WebXRController;
	function update(inputSource:js.three.renderers.webxr.WebXRSpaceEventMap.XRInputSource, frame:js.three.renderers.webxr.WebXRController.XRFrame, referenceSpace:js.three.renderers.webxr.WebXRController.XRReferenceSpace):js.three.renderers.webxr.WebXRController;
}