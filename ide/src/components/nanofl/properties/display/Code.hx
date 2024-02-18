package components.nanofl.properties.display;

import nanofl.ide.PropertiesObject;

class Code extends components.nanofl.properties.base.Code
{
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				show();
				template().blendMode.val(item.element.blendMode);
				
			case _:
				hide();
		};
		
		freeze = false;
	}
	
	function blendMode_change(_)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				item.element.blendMode = template().blendMode.val();
				bind(obj);
				
			case _:
		}
		
		fireChangeEvent();
	}
}