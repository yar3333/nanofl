package js.three.renderers.webgl;

typedef WebGLCapabilitiesParameters = {
	@:optional
	var logarithmicDepthBuffer : haxe.extern.EitherType<Bool, { }>;
	@:optional
	var precision : haxe.extern.EitherType<String, { }>;
};