package nanofl;

extern class Mesh extends nanofl.SolidContainer {
	function new(symbol:nanofl.engine.libraryitems.MeshItem):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.MeshItem;
	var rotationX : Float;
	var rotationY : Float;
	var rotationZ : Float;
	var scene : js.three.scenes.Scene;
	var group : js.three.objects.Group<js.three.core.Object3DEventMap>;
	var camera(default, null) : js.three.cameras.PerspectiveCamera;
	var autoCamera : Bool;
	var ambientLight(default, null) : js.three.lights.AmbientLight;
	var directionalLight(default, null) : js.three.lights.DirectionalLight;
	override function clone(?recursive:Bool):nanofl.Mesh;
	override function toString():String;
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	function update():Void;
}