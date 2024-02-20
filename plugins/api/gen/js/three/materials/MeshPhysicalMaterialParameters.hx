package js.three.materials;

typedef MeshPhysicalMaterialParameters = {
	@:optional
	var alphaHash : Bool;
	@:optional
	var alphaMap : js.three.textures.Texture;
	@:optional
	var alphaTest : Float;
	@:optional
	var alphaToCoverage : Bool;
	@:optional
	var anisotropy : Float;
	@:optional
	var anisotropyMap : js.three.textures.Texture;
	@:optional
	var anisotropyRotation : Float;
	@:optional
	var aoMap : js.three.textures.Texture;
	@:optional
	var aoMapIntensity : Float;
	@:optional
	var attenuationColor : js.three.math.ColorRepresentation;
	@:optional
	var attenuationDistance : Float;
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
	var clearcoat : Float;
	@:optional
	var clearcoatMap : js.three.textures.Texture;
	@:optional
	var clearcoatNormalMap : js.three.textures.Texture;
	@:optional
	var clearcoatNormalScale : js.three.math.Vector2;
	@:optional
	var clearcoatRoughness : Float;
	@:optional
	var clearcoatRoughnessMap : js.three.textures.Texture;
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
	var ior : Float;
	@:optional
	var iridescence : Float;
	@:optional
	var iridescenceIOR : Float;
	@:optional
	var iridescenceMap : js.three.textures.Texture;
	@:optional
	var iridescenceThicknessMap : js.three.textures.Texture;
	@:optional
	var iridescenceThicknessRange : Array<Float>;
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
	var reflectivity : Float;
	@:optional
	var roughness : Float;
	@:optional
	var roughnessMap : js.three.textures.Texture;
	@:optional
	var shadowSide : js.three.Side;
	@:optional
	var sheen : Float;
	@:optional
	var sheenColor : js.three.math.ColorRepresentation;
	@:optional
	var sheenColorMap : js.three.textures.Texture;
	@:optional
	var sheenRoughness : Float;
	@:optional
	var sheenRoughnessMap : js.three.textures.Texture;
	@:optional
	var side : js.three.Side;
	@:optional
	var specularColor : js.three.math.ColorRepresentation;
	@:optional
	var specularColorMap : js.three.textures.Texture;
	@:optional
	var specularIntensity : Float;
	@:optional
	var specularIntensityMap : js.three.textures.Texture;
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
	var thickness : Float;
	@:optional
	var thicknessMap : js.three.textures.Texture;
	@:optional
	var toneMapped : Bool;
	@:optional
	var transmission : Float;
	@:optional
	var transmissionMap : js.three.textures.Texture;
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