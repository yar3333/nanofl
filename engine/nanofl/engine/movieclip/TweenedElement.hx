package nanofl.engine.movieclip;

import nanofl.engine.elements.Element;

class TweenedElement
{
	public var original : Element;
	public var current : Element;
	
	public function new(original:Element, current:Element)
	{
		this.original = original;
		this.current = current;
	}
}