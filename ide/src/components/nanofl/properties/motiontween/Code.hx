package components.nanofl.properties.motiontween;

import nanofl.engine.libraryitems.MeshItem;
import nanofl.engine.elements.Instance;
import nanofl.ide.PropertiesObject;
import stdlib.Std;
using stdlib.Lambda;

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
			case PropertiesObject.KEY_FRAME(keyFrame):
				if (keyFrame.hasMotionTween())
				{
					var motionTween = keyFrame.getMotionTween();
					
					show();
					
					template().easing.value = motionTween.easing;
					template().rotateCount.val(motionTween.rotateCount);
					template().orientToPath.prop("checked", motionTween.orientToPath);
					
					template().rotateCount.prop("disabled", motionTween.orientToPath);
					
					if (keyFrame.elements.exists(e -> Std.isOfType(e, Instance) && Std.isOfType((cast e:Instance).symbol, MeshItem)))
                    {
						template().rotateCountXContainer.show();
						template().rotateCountX.val(motionTween.rotateCountX);
						
						template().rotateCountYContainer.show();
						template().rotateCountY.val(motionTween.rotateCountY);
					}
					else
					{
						template().rotateCountXContainer.hide();
						template().rotateCountX.val(0);
						
						template().rotateCountYContainer.hide();
						template().rotateCountY.val(0);
					}
				}
				else
				{
					hide();
				}
				
			case _:
				hide();
		};
	}
	
	function easing_change(_) changeProperties();
	function rotateCount_change(_) changeProperties();
	function orientToPath_change(_) changeProperties();
	function rotateCountX_change(_) changeProperties();
	function rotateCountY_change(_) changeProperties();
	
	function changeProperties()
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.KEY_FRAME(keyFrame):
				if (keyFrame.hasMotionTween())
				{
					var motionTween = keyFrame.getMotionTween();
					
					undoQueue.beginTransaction({ timeline:true });
					
					motionTween.easing = Std.int(template().easing.value);
					motionTween.rotateCount = Std.parseInt(template().rotateCount.val(), 0);
					motionTween.orientToPath = template().orientToPath.prop("checked");
					motionTween.rotateCountX = Std.parseInt(template().rotateCountX.val(), 0);
					motionTween.rotateCountY = Std.parseInt(template().rotateCountY.val(), 0);
					
					undoQueue.commitTransaction();
					
					update();
					
					fireChangeEvent();
				}
				
			case _:
		}
	}
}