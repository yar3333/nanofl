package nanofl;

@:expose
class Stage extends easeljs.display.Stage
{
	public function new(canvas:Dynamic) 
	{
		super(canvas);

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