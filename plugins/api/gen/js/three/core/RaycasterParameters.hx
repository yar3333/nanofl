package js.three.core;

typedef RaycasterParameters = {
	var LOD : Dynamic;
	var Line : { var threshold : Float; };
	@:optional
	var Line2 : { public var threshold(default, default) : Float; };
	var Mesh : Dynamic;
	var Points : { var threshold : Float; };
	var Sprite : Dynamic;
};