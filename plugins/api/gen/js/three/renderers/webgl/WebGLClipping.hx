package js.three.renderers.webgl;

@:native("THREE.WebGLClipping") extern class WebGLClipping {
	function new(properties:js.three.renderers.webgl.WebGLProperties):Void;
	var uniform : { var needsUpdate : Bool; var value : Dynamic; };
	/**
		
			 * @default 0
			 
	**/
	var numPlanes : Float;
	/**
		
			 * @default 0
			 
	**/
	var numIntersection : Float;
	function init(planes:Array<Dynamic>, enableLocalClipping:Bool):Bool;
	function beginShadows():Void;
	function endShadows():Void;
	function setGlobalState(planes:Array<js.three.math.Plane>, camera:js.three.cameras.Camera):Void;
	function setState(material:js.three.materials.Material, camera:js.three.cameras.Camera, useCache:Bool):Void;
}