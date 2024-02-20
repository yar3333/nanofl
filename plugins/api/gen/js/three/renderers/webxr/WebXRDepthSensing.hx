package js.three.renderers.webxr;

typedef XRRenderState = Dynamic;

typedef WebXRArrayCamera = Dynamic;

@:native("THREE.WebXRDepthSensing") extern class WebXRDepthSensing {
	function new():Void;
	var texture : js.three.textures.Texture;
	var mesh : js.three.objects.Mesh<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap>;
	var depthNear : Float;
	var depthFar : Float;
	function init(renderer:js.three.renderers.WebGLRenderer, depthData:js.three.renderers.webxr.XRWebGLDepthInformation, renderState:js.three.renderers.webxr.WebXRDepthSensing.XRRenderState):Void;
	function render(renderer:js.three.renderers.WebGLRenderer, cameraXR:js.three.renderers.webxr.WebXRDepthSensing.WebXRArrayCamera):Void;
	function reset():Void;
}