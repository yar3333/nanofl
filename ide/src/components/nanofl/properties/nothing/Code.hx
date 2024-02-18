package components.nanofl.properties.nothing;

import nanofl.ide.PropertiesObject;

class Code extends components.nanofl.properties.base.Code
{
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.NONE:
				show();
				
			case _:
				hide();
		};
	}
}