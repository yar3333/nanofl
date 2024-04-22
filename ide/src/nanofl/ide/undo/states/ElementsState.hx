package nanofl.ide.undo.states;

import nanofl.engine.elements.Element;

class ElementsState
{
	public var layerElements(default, null) : Array<{ elements:Array<Element>}>;
	
	public function new(layerElements:Array<{ elements:Array<Element> }>)
	{
		this.layerElements = layerElements;
	}

    public function toString() 
    {
        final r = [];
        for (layer in layerElements) 
        for (element in layer.elements) 
            r.push("\t" + element.matrix);
        return r.join("\n");
    }
}
