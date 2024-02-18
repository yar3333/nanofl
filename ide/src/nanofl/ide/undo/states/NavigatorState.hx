package nanofl.ide.undo.states;

class NavigatorState
{
	public var first(default, null) : { namePath:String, layerIndex:Int, frameIndex:Int };
	public var nexts(default, null) : Array<{ elementIndex:Int, layerIndex:Int, frameIndex:Int }>;
	
	public function new(first:{ namePath:String, layerIndex:Int, frameIndex:Int }, nexts:Array<{ elementIndex:Int, layerIndex:Int, frameIndex:Int }>)
	{
		this.first = first;
		this.nexts = nexts;
	}
}
