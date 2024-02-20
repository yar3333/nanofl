package js.three.materials;

typedef ShaderMaterialParameters = {
	@:optional
	var alphaHash : Bool;
	@:optional
	var alphaTest : Float;
	@:optional
	var alphaToCoverage : Bool;
	@:optional
	var blendAlpha : Float;
	@:optional
	var blendColor : js.three.math.ColorRepresentation;
	@:optional
	var blendDst : js.three.BlendingDstFactor;
	@:optional
	var blendDstAlpha : Float;
	@:optional
	var blendEquation : js.three.BlendingEquation;
	@:optional
	var blendEquationAlpha : Float;
	@:optional
	var blendSrc : haxe.extern.EitherType<js.three.BlendingSrcFactor, js.three.BlendingDstFactor>;
	@:optional
	var blendSrcAlpha : Float;
	@:optional
	var blending : js.three.Blending;
	@:optional
	var clipIntersection : Bool;
	@:optional
	var clipShadows : Bool;
	@:optional
	var clipping : Bool;
	@:optional
	var clippingPlanes : Array<js.three.math.Plane>;
	@:optional
	var colorWrite : Bool;
	@:optional
	var defines : Dynamic;
	@:optional
	var depthFunc : js.three.DepthModes;
	@:optional
	var depthTest : Bool;
	@:optional
	var depthWrite : Bool;
	@:optional
	var dithering : Bool;
	@:optional
	var extensions : { @:optional
	public var shaderTextureLOD(default, default) : Bool; @:optional
	public var fragDepth(default, default) : Bool; @:optional
	public var drawBuffers(default, default) : Bool; @:optional
	public var derivatives(default, default) : Bool; };
	@:optional
	var fog : Bool;
	@:optional
	var forceSinglePass : Bool;
	@:optional
	var format : js.three.PixelFormat;
	@:optional
	var fragmentShader : String;
	@:optional
	var glslVersion : js.three.GLSLVersion;
	@:optional
	var lights : Bool;
	@:optional
	var linewidth : Float;
	@:optional
	var name : String;
	@:optional
	var opacity : Float;
	@:optional
	var polygonOffset : Bool;
	@:optional
	var polygonOffsetFactor : Float;
	@:optional
	var polygonOffsetUnits : Float;
	@:optional
	var precision : js.three.Precision;
	@:optional
	var premultipliedAlpha : Bool;
	@:optional
	var shadowSide : js.three.Side;
	@:optional
	var side : js.three.Side;
	@:optional
	var stencilFail : js.three.StencilOp;
	@:optional
	var stencilFunc : js.three.StencilFunc;
	@:optional
	var stencilFuncMask : Float;
	@:optional
	var stencilRef : Float;
	@:optional
	var stencilWrite : Bool;
	@:optional
	var stencilWriteMask : Float;
	@:optional
	var stencilZFail : js.three.StencilOp;
	@:optional
	var stencilZPass : js.three.StencilOp;
	@:optional
	var toneMapped : Bool;
	@:optional
	var transparent : Bool;
	@:optional
	var uniforms : Dynamic<js.three.renderers.shaders.IUniform<Dynamic>>;
	@:optional
	var uniformsGroups : Array<js.three.core.UniformsGroup>;
	@:optional
	var userData : Dynamic;
	@:optional
	var vertexColors : Bool;
	@:optional
	var vertexShader : String;
	@:optional
	var visible : Bool;
	@:optional
	var wireframe : Bool;
	@:optional
	var wireframeLinewidth : Float;
};