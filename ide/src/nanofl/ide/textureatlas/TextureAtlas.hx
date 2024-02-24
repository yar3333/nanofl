package nanofl.ide.textureatlas;

typedef TextureAtlas =
{
	var imagePngAsBase64 : String;
	var frames : Array<TextureAtlasFrame>;
	var itemFrames : Dynamic<Array<Int>>;
}