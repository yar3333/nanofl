package nanofl;

extern class Mesh extends nanofl.SolidContainer implements nanofl.engine.InstanceDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.MeshItem, params:nanofl.engine.MeshParams):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.MeshItem;
	var rotationX : Float;
	var rotationY : Float;
	var rotationZ : Float;
	var renderer(default, null) : js.three.renderers.WebGLRenderer;
	var bitmap(default, null) : easeljs.display.Bitmap;
	var scene(default, null) : js.three.scenes.Scene;
	var group(default, null) : js.three.objects.Group<js.three.core.Object3DEventMap>;
	var camera : js.three.cameras.PerspectiveCamera;
	var autoCamera : Bool;
	var ambientLight(default, null) : js.three.lights.AmbientLight;
	var directionalLight(default, null) : js.three.lights.DirectionalLight;
	/**
		
		        Scale factor for rendering area (256x256). Default is 2.0.
		    
	**/
	function setQuality(q:Float):Void;
	override function clone(?recursive:Bool):nanofl.Mesh;
	override function toString():String;
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
}