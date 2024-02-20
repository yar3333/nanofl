package nanofl.ide.textureatlas;

typedef TextureAtlas = {
	var frames : Array<nanofl.ide.textureatlas.TextureAtlasFrame>;
	var imagePng : haxe.io.Bytes;
	var itemFrames : Dynamic<Array<Int>>;
};