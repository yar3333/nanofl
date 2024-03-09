package nanofl.ide.editor;

import stdlib.Debug;
import datatools.ArrayTools;
import nanofl.ide.navigator.PathItem;
import easeljs.display.Container;

class EditorMilk extends Container
{
	static final MILK_POWER = 0.5;
	static final MILK_COLOR = 255;

	final app : Application;
    var lastMilkEditPath : Array<PathItem>;

    public function new(app:Application)
    {
        super();

        this.app = app;
        		
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

        var obj : MovieClip = cast milkChild;
        for (i in 0...editPath.length)
        {
            Debug.assert(Std.isOfType(obj, MovieClip));
            
            if (i < editPath.length - 1)
            {
                obj.advanceTo(editPath[i].frameIndex);
                obj = cast obj.getChildByElement(editPath[i + 1].element);
            }
            else
            {
                obj.visible = false;
            }
        }

		addChild(milkChild);

        DisplayObjectTools.recache(this);
    }
}