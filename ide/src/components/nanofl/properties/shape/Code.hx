package components.nanofl.properties.shape;

import nanofl.ide.PropertiesObject;

class Code extends components.nanofl.properties.base.Code
{
	static var imports =
	{
		"slider": components.nanofl.common.slider.Code
	};

	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.SHAPE(_, newObjectParams, options):
				if (options.roundRadiusPane)
				{
					show();
					template().radius.value = newObjectParams.roundRadius;
				}
				else
				{
					hide();
				}
				
			case _:
				hide();
		};
	}
	
	function radius_change(e) changeProperties();
	
	function changeProperties()
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.SHAPE(_, newObjectParams, options):
				if (options.roundRadiusPane) newObjectParams.roundRadius = template().radius.value;
				
			case _:
		}
	}
}