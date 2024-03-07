package nanofl.ide.editor;

import stdlib.Debug;
import datatools.ArrayTools;
import nanofl.ide.navigator.PathItem;
import easeljs.display.Container;

class EditorMilk extends Container
{
	static final MILK_POWER = 0.5;
	static final MILK_COLOR = 255;

	@inject var app : Application;
	
    var lastMilkEditPath : Array<PathItem>;

    public function new()
    {
        super();
		
        Globals.injector.injectInto(this);
        		
        filters = [ new easeljs.filters.ColorFilter(1 - MILK_POWER, 1 - MILK_POWER, 1 - MILK_POWER, 1, MILK_COLOR * MILK_POWER, MILK_COLOR * MILK_POWER, MILK_COLOR * MILK_POWER, 0) ];
    }

    public function update()
    {
        final editPath = app.document.navigator.editPath;
		if (lastMilkEditPath != null && ArrayTools.equ(editPath, lastMilkEditPath)) return;
		
		lastMilkEditPath = editPath.map(x -> x.clone());
		
		uncache();
		removeAllChildren();
		
		editPath[editPath.length - 1].element.visible = false;
        final milkChild = editPath[0].element.createDisplayObject();
		editPath[editPath.length - 1].element.visible = true;

        // move pathItems to top & set currentFrame
        var obj : Container = cast milkChild;
        for (i in 0...(editPath.length - 2))
        {
            Debug.assert(Std.isOfType(obj, Container));

            if (editPath[i].frameIndex != 0)
            {
                Debug.assert(Std.isOfType(obj, MovieClip));
                (cast obj : MovieClip).gotoAndStop(editPath[i].frameIndex);
            }
            
            final n = editPath[i].element.getChildren().indexOf(cast editPath[i + 1].element);
            Debug.assert(n >= 0);
            final child : Container = cast obj.getChildAt(n); 
            obj.removeChildAt(n);
            obj.addChild(child);
            obj = child;
        }

		addChild(milkChild);

        DisplayObjectTools.recache(this);
    }
}