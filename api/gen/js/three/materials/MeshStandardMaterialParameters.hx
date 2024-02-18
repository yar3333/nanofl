package js.three.materials;

typedef MeshStandardMaterialParameters = {
	@:optional
	var alphaHash : Bool;
	@:optional
	var alphaMap : js.three.textures.Texture;
	@:optional
	var alphaTest : Float;
	@:optional
	var alphaToCoverage : Bool;
	@:optional
	var aoMap : js.three.textures.Texture;
	@:optional
	var aoMapIntensity : Float;
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
	var bumpMap : js.three.textures.Texture;
	@:optional
	var bumpScale : Float;
	@:optional
	var clipIntersection : Bool;
	@:optional
	var clipShadows : Bool;
	@:optional
	var clippingPlanes : Array<js.three.math.Plane>;
	@:optional
	var color : js.three.math.ColorRepresentation;
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
	var displacementBias : Float;
	@:optional
	var displacementMap : js.three.textures.Texture;
	@:optional
	var displacementScale : Float;
	@:optional
	var dithering : Bool;
	@:optional
	var emissive : js.three.math.ColorRepresentation;
	@:optional
	var emissiveIntensity : Float;
	@:optional
	var emissiveMap : js.three.textures.Texture;
	@:optional
	var envMap : js.three.textures.Texture;
	@:optional
	var envMapIntensity : Float;
	@:optional
	var flatShading : Bool;
	@:optional
	var fog : Bool;
	@:optional
	var forceSinglePass : Bool;
	@:optional
	var format : js.three.PixelFormat;
	@:optional
	var lightMap : js.three.textures.Texture;
	@:optional
	var lightMapIntensity : Float;
	@:optional
	var map : js.three.textures.Texture;
	@:optional
	var metalness : Float;
	@:optional
	var metalnessMap : js.three.textures.Texture;
	@:optional
	var name : String;
	@:optional
	var normalMap : js.three.textures.Texture;
	@:optional
	var normalMapType : js.three.NormalMapTypes;
	@:optional
	var normalScale : js.three.math.Vector2;
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
	var roughness : Float;
	@:optional
	var roughnessMap : js.three.textures.Texture;
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
	var userData : Dynamic;
	@:optional
	var vertexColors : Bool;
	@:optional
	var visible : Bool;
	@:optional
	var wireframe : Bool;
	@:optional
	var wireframeLinewidth : Float;
};