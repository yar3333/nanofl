package nanofl.ide.textureatlas;

typedef ImageData = {
	var canvas : js.html.CanvasElement;
	var refs : Array<{ public var regY(default, default) : Float; public var regX(default, default) : Float; public var namePath(default, default) : String; public var frameIndex(default, default) : Int; }>;
};