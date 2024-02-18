package nanofl.ide.textureatlas;

typedef TextureAtlas =
{
	var imagePng : haxe.io.Bytes;
	var frames : Array<TextureAtlasFrame>;
	var itemFrames : Dynamic<Array<Int>>;
}