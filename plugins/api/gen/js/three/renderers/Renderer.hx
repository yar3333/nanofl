package js.three.renderers;

extern interface Renderer {
	var domElement : js.html.CanvasElement;
	function render(scene:js.three.core.Object3D<js.three.core.Object3DEventMap>, camera:js.three.cameras.Camera):Void;
	function setSize(width:Float, height:Float, ?updateStyle:Bool):Void;
}