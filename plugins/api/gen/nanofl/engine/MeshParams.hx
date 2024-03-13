package nanofl.engine;

typedef MeshParams = {
	@:optional
	var ambientLightColor : String;
	@:optional
	var cameraFov : Float;
	@:optional
	var directionalLightColor : String;
	@:optional
	var directionalLightRotationX : Float;
	@:optional
	var directionalLightRotationY : Float;
	@:optional
	var rotationX : Float;
	@:optional
	var rotationY : Float;
};

extern class MeshParamsTools {
	static function createDefault():nanofl.engine.MeshParams;
	static function load(base:htmlparser.HtmlNodeElement):nanofl.engine.MeshParams;
	static function loadJson(obj:Dynamic):nanofl.engine.MeshParams;
	static function save(params:nanofl.engine.MeshParams, out:htmlparser.XmlBuilder):Void;
	static function saveJson(params:nanofl.engine.MeshParams):Dynamic;
	static function equ(a:nanofl.engine.MeshParams, b:nanofl.engine.MeshParams):Bool;
	static function clone(params:nanofl.engine.MeshParams):nanofl.engine.MeshParams;
	static function applyToMesh(params:nanofl.engine.MeshParams, mesh:nanofl.Mesh):Void;
}