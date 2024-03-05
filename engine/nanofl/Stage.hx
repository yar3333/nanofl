package nanofl;

import nanofl.engine.LayerType;
import js.lib.Map;
import easeljs.display.Container;
import easeljs.display.DisplayObject;

@:expose
class Stage extends easeljs.display.Stage
{
    public var framerate(default, null) : Float;

	public function new(canvas:Dynamic, framerate:Float) 
	{
		super(canvas);
        
        this.framerate = framerate;

		tickOnUpdate = false;
		
		#if !ide
		enableMouseOver(10); // TODO: avoid this?

        addStageMouseDownEventListener(e ->
        {
            DisplayObjectTools.dispatchMouseEvent(this, "onMouseDown", new nanofl.MouseEvent(e.stageX, e.stageY));
        });
        addStageMouseMoveEventListener(e ->
        {
            DisplayObjectTools.dispatchMouseEvent(this, "onMouseMove", new nanofl.MouseEvent(e.stageX, e.stageY));
        });
        addStageMouseUpEventListener(e ->
        {
            DisplayObjectTools.dispatchMouseEvent(this, "onMouseUp", new nanofl.MouseEvent(e.stageX, e.stageY));
        });
		#end
	}
	
	override public function update(?params:Dynamic)
	{
        for (child in children) DisplayObjectTools.recache(child);
        super.update(params);
	}
}