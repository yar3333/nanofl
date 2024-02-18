package nanofl.engine;

import nanofl.engine.elements.Element;
import nanofl.engine.elements.GroupElement;
import nanofl.engine.movieclip.KeyFrame;

class GroupKeyFrame extends KeyFrame
{
	var group : GroupElement;
	
	public function new(group:GroupElement)
	{
		super(group._elements);
		this.group = group;
		for (element in elements) element.parent = group;
	}
	
	override public function addElement(element:Element, ?index:Int) 
	{
		super.addElement(element, index);
		element.parent = group;
	}
	
	override public function duplicate(?label:String, ?duration:Int, ?elements:Array<Element>) : KeyFrame return stdlib.Debug.methodNotSupported(this);
}