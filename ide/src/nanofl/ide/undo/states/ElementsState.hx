package nanofl.ide.undo.states;

class ElementsState<Element>
{
	public var layerElements(default, null) : Array<{ elements:Array<Element>}>;
	
	public function new(layerElements:Array<{ elements:Array<Element> }>)
	{
		this.layerElements = layerElements;
	}
}
