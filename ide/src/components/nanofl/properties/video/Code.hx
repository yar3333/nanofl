package components.nanofl.properties.video;

import stdlib.Std;
import nanofl.ide.displayobjects.IdeVideo;
import js.html.InputElement;
import nanofl.engine.elements.Instance;
import nanofl.ide.libraryitems.VideoItem;
import nanofl.ide.PropertiesObject;

#if profiler @:build(Profiler.buildMarked()) #end
class Code extends components.nanofl.properties.base.Code
{
	static var imports =
	{
		//"color-selector": components.nanofl.common.color.Code,
	};
	
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.isOfType(item.element.symbol, VideoItem)):
                show();

                //final element : Instance = cast item.currentElement;

                final isKeyFrame = app.document.navigator.pathItem.frame.subIndex == 0;
                
                template().currentTime.val(roundFloat1000((cast item.dispObj : IdeVideo).currentTime));

                template().seekTo.val
                (
                    isKeyFrame && item.element.videoCurrentTime != null 
                        ? roundFloat1000(item.element.videoCurrentTime) + ""
                        : ""
                );

                (cast template().seekTo[0] : InputElement).readOnly = !isKeyFrame;
                
			case _:
				hide();
		};
	}
	
	function seekTo_change(_)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, VideoItem)):
				undoQueue.beginTransaction({ element:item.element });
                final str = template().seekTo.val();
                item.element.videoCurrentTime = Std.parseFloat(str, -1) >= 0 ? Std.parseFloat(str) : null;
                undoQueue.commitTransaction();
            case _:
        }

        fireChangeEvent();
	}
}