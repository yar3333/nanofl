package nanofl.ide.textureatlas;

@:rtti
class TextureAtlasParams
{
	public var width : Int;
	public var height : Int;
	public var padding : Int;
	
	public function new(width=2048, height=2048, padding=0)
	{
		this.width = width;
		this.height = height;
		this.padding = padding;
	}
	
	public function equ(p:TextureAtlasParams) : Bool
	{
		return p.width == width && p.height == height && p.padding == padding;
	}
	
	public function clone() : TextureAtlasParams
	{
		return new TextureAtlasParams(width, height, padding);
	}
}