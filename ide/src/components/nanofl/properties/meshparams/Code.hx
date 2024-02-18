package components.nanofl.properties.meshparams;

import nanofl.ide.PropertiesObject;
import nanofl.engine.libraryitems.MeshItem;

#if profiler @:build(Profiler.buildMarked()) #end
class Code extends components.nanofl.properties.base.Code
{
	static var imports =
	{
		"color-selector": components.nanofl.common.color.Code,
		"slider": components.nanofl.common.slider.Code
	};
	
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
                show();
                
                template().rotationX.value = roundFloat100(item.element.meshParams.rotationX);
                template().rotationY.value = roundFloat100(item.element.meshParams.rotationY);
                template().cameraFov.value = item.element.meshParams.cameraFov;
                template().ambientLightColor.value = item.element.meshParams.ambientLightColor;
                template().directionalLightColor.value = item.element.meshParams.directionalLightColor;
                template().directionalLightRotationX.value = roundFloat100(item.element.meshParams.directionalLightRotationX);
                template().directionalLightRotationY.value = roundFloat100(item.element.meshParams.directionalLightRotationY);
                
			case _:
				hide();
		};
	}
	
	function rotationX_change(e:{ value:Float })
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
        		item.element.meshParams.rotationX = e.value;
            case _:
        }

        fireChangeEvent();
	}
	
	function rotationY_change(e:{ value:Float })
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
        		item.element.meshParams.rotationY = e.value;
            case _:
        }
                
		fireChangeEvent();
	}
	
	function cameraFov_change(e:{ value:Float })
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
        		item.element.meshParams.cameraFov = Math.round(e.value);
            case _:
        }
                
		fireChangeEvent();
	}
	
	function ambientLightColor_change(e:{ color:String })
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
        		item.element.meshParams.ambientLightColor = e.color;
            case _:
        }
                
		fireChangeEvent();
	}
	
	function directionalLightColor_change(e:{ color:String })
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
        		item.element.meshParams.directionalLightColor = e.color;
            case _:
        }
                
		fireChangeEvent();
	}
	
	function directionalLightRotationX_change(e:{ value:Float })
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
        		item.element.meshParams.directionalLightRotationX = Math.round(e.value);
            case _:
        }
                
		fireChangeEvent();
	}
	
	function directionalLightRotationY_change(e:{ value:Float })
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item) if (Std.is(item.element.symbol, MeshItem)):
        		item.element.meshParams.directionalLightRotationY = Math.round(e.value);
            case _:
        }
                
		fireChangeEvent();
	}
}