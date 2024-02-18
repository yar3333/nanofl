package nanofl.ide.textureatlas;

class Packed<T>
{
	public var rect    (default, null) : TRect;
	public var data    (default, null) : T;
	public var rotated (default, null) : Bool;

	public function new(rect:TRect, data:T, rotated=false)
	{
		this.rect    = rect;
		this.data    = data;
		this.rotated = rotated;
	}
}
