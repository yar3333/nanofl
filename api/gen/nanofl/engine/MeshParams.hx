package nanofl.engine;

extern class MeshParams {
	function new():Void;
	var rotationX : Float;
	var rotationY : Float;
	var cameraFov : Int;
	var ambientLightColor : String;
	var directionalLightColor : String;
	var directionalLightRotationX : Float;
	var directionalLightRotationY : Float;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():Dynamic;
	function equ(obj:nanofl.engine.MeshParams):Bool;
	function clone():nanofl.engine.MeshParams;
	function applyToMesh(mesh:nanofl.Mesh):Void;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.MeshParams;
	static function loadJson(obj:Dynamic):nanofl.engine.MeshParams;
}