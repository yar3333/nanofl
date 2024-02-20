package js.html.webgl;

typedef ContextAttributes = {
	@:optional
	var alpha : Bool;
	@:optional
	var antialias : Bool;
	@:optional
	var depth : Bool;
	@:optional
	var failIfMajorPerformanceCaveat : Bool;
	@:optional
	var powerPreference : js.html.webgl.PowerPreference;
	@:optional
	var premultipliedAlpha : Bool;
	@:optional
	var preserveDrawingBuffer : Bool;
	@:optional
	var stencil : Bool;
};