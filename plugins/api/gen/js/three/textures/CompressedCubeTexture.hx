package js.three.textures;

@:native("THREE.CompressedCubeTexture") extern class CompressedCubeTexture extends js.three.textures.CompressedTexture {
	function new(images:Array<{ public var width(default, default) : Float; public var height(default, default) : Float; }>, ?format:js.three.CompressedPixelFormat, ?type:js.three.TextureDataType):Void;
	var isCompressedCubeTexture(default, null) : Bool;
	var isCubeTexture(default, null) : Bool;
}