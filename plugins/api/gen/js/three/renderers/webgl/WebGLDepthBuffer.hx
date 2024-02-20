package js.three.renderers.webgl;

@:native("THREE.WebGLDepthBuffer") extern class WebGLDepthBuffer {
	function new():Void;
	function setTest(depthTest:Bool):Void;
	function setMask(depthMask:Bool):Void;
	function setFunc(depthFunc:js.three.DepthModes):Void;
	function setLocked(lock:Bool):Void;
	function setClear(depth:Float):Void;
	function reset():Void;
}