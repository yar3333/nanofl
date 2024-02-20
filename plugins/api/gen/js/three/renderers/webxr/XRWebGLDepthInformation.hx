package js.three.renderers.webxr;

extern interface XRWebGLDepthInformation {
	var texture(default, null) : js.html.webgl.WebGLTexture;
	var depthNear(default, null) : Float;
	var depthFar(default, null) : Float;
}