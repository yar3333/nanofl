package components.nanofl.properties.framelabel;

import nanofl.ide.PropertiesObject;

class Code extends components.nanofl.properties.base.Code
{
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.KEY_FRAME(keyFrame):
				show();
				template().label.val(keyFrame.label);
				
			case _:
				hide();
		};
	}
	
	function label_change(_)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.KEY_FRAME(keyFrame):
				keyFrame.label = template().label.val();
				
			case _:
		}
		
		fireChangeEvent();
	}
}