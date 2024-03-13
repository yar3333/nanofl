package nanofl;

import js.lib.Promise;

@:expose
class Stage extends easeljs.display.Stage
{
    public var framerate : Float;
	public var recacheOnUpdate : Bool;
    
    public function new(canvas:Dynamic, framerate:Float)
	{
		super(canvas);

        this.framerate = framerate;
        
        this.tickOnUpdate = false;
		
        recacheOnUpdate = true;
		
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
        if (recacheOnUpdate)
        {
            for (child in children)
            {
                DisplayObjectTools.recache(child);
            }
        }

        super.update(params);
	}

    #if ide
    public function waitLoading() : Promise<{}>
    {
        final promises = new Array<Promise<{}>>();

        DisplayObjectTools.iterateTreeFromBottomToTop(this, true, obj ->
        {
            if (!Std.isOfType(obj, nanofl.ide.displayobjects.IdeVideo)) return;
            
            final videoObj : nanofl.ide.displayobjects.IdeVideo = cast obj;

            if (videoObj.video.readyState < js.html.MediaElement.HAVE_CURRENT_DATA)
            {
                promises.push(new Promise<{}>((resolve, reject) ->
                {
                    videoObj.video.addEventListener("canplaythrough", () -> resolve(null), { once:true });
                    videoObj.video.addEventListener("error", e -> reject(e), { once:true });
                }));
            }
        });

        return Promise.all(promises).then(_ -> null);
    }
    #end
}