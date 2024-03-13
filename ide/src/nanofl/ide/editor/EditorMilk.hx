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
		if (lastMilkEditPath != null 
            && ArrayTools.equ(editPath.slice(0, editPath.length - 1), lastMilkEditPath.slice(0, lastMilkEditPath.length - 1)) 
            && editPath[editPath.length - 1].instance == lastMilkEditPath[lastMilkEditPath.length - 1].instance) return;
		
		lastMilkEditPath = editPath.map(x -> x.clone());
		
		uncache();
		removeAllChildren();
		
        final milkChild = editPath[0].mcItem.createDisplayObject(null);

        var obj : MovieClip = cast milkChild;
        for (i in 0...editPath.length)
        {
            Debug.assert(Std.isOfType(obj, MovieClip));
            
            if (i < editPath.length - 1)
            {
                obj.advanceTo(editPath[i].frameIndex, app.document.properties.framerate);
                obj = cast obj.getChildByElement(editPath[i + 1].instance);
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