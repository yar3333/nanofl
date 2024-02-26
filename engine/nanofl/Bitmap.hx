package nanofl;

import nanofl.engine.libraryitems.InstancableItem;

@:expose
class Bitmap extends easeljs.display.Bitmap #if !ide implements IEventHandlers #end
{
	public var symbol(default, null) : InstancableItem;
	
	public function new(symbol:InstancableItem)
	{
		super(null);
		this.symbol = symbol;
		symbol.updateDisplayObject(this, null);
	}
	
	override public function clone(?recursive:Bool) : Bitmap
	{
		return (cast this)._cloneProps
		(
			new Bitmap(symbol)
		);
	}
	
	override public function toString() : String 
	{
		return symbol.toString();
	}
	
	
	#if !ide
	
	//{ IEventHandlers
	public function onEnterFrame() : Void {}
	public function onMouseDown(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseMove(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseUp(e:easeljs.events.MouseEvent) : Void {}
	//}
	
	#end
}