package nanofl.ide.textureatlas;

extern class TextureAtlases {
	static function load(node:htmlparser.HtmlNodeElement):Map<String, nanofl.ide.textureatlas.TextureAtlasParams>;
	static function save(textureAtlases:Map<String, nanofl.ide.textureatlas.TextureAtlasParams>, out:htmlparser.XmlBuilder):Void;
}