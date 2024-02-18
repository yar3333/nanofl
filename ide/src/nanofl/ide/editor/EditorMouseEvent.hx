package nanofl.ide.editor;

import easeljs.display.DisplayObject;
import easeljs.events.MouseEvent;

class EditorMouseEvent extends Invalidater
{
	public var x : Float;
	public var y : Float;
	
	public var ctrlKey : Bool;
	public var shiftKey : Bool;
	
	public function new(native:MouseEvent, container:DisplayObject)
	{
		super();
		
		var pt = container.globalToLocal(native.rawX, native.rawY);
		this.x = pt.x;
		this.y = pt.y;
		
		this.ctrlKey = native.nativeEvent.ctrlKey;
		this.shiftKey = native.nativeEvent.shiftKey;
	}
}