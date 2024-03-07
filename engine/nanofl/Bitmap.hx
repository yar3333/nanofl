package nanofl;

import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.libraryitems.BitmapItem;

@:expose
class Bitmap extends easeljs.display.Bitmap 
    implements InstanceDisplayObject
    #if !ide implements IEventHandlers #end
{
	public var symbol(default, null) : BitmapItem;
	
	public function new(symbol:BitmapItem)
	{
		super(null);
		this.symbol = symbol;
		image = symbol.image;
		setBounds(0, 0, symbol.image.width, symbol.image.height);
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