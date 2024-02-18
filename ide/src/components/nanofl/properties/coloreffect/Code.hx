package components.nanofl.properties.coloreffect;

import nanofl.ide.PropertiesObject;
import nanofl.engine.coloreffects.ColorEffectAdvanced;
import nanofl.engine.coloreffects.ColorEffectAlpha;
import nanofl.engine.coloreffects.ColorEffectBrightness;
import nanofl.engine.coloreffects.ColorEffectTint;

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
			case PropertiesObject.INSTANCE(item):
				show();
				
				var n = 0;
				if (Std.isOfType(item.element.colorEffect, ColorEffectBrightness))
				{
					n = 1;
					template().brightness.value = cast(item.element.colorEffect, ColorEffectBrightness).value * 100;
				}
				else
				if (Std.isOfType(item.element.colorEffect, ColorEffectTint))
				{
					n = 2;
					template().tint.value = cast(item.element.colorEffect, ColorEffectTint).multiplier * 100;
					template().color.value = cast(item.element.colorEffect, ColorEffectTint).color;
				}
				else
				if (Std.isOfType(item.element.colorEffect, ColorEffectAdvanced))
				{
					n = 3;
					var ce = cast(item.element.colorEffect, ColorEffectAdvanced);
					template().colorMulR.val(ce.redMultiplier * 100);
					template().colorAddR.val(ce.redOffset);
					template().colorMulG.val(ce.greenMultiplier * 100);
					template().colorAddG.val(ce.greenOffset);
					template().colorMulB.val(ce.blueMultiplier * 100);
					template().colorAddB.val(ce.blueOffset);
					template().colorMulA.val(ce.alphaMultiplier * 100);
					template().colorAddA.val(ce.alphaOffset);
				}
				else
				if (Std.isOfType(item.element.colorEffect, ColorEffectAlpha))
				{
					n = 4;
					template().alpha.value = cast(item.element.colorEffect, ColorEffectAlpha).value * 100;
				}
				
				template().color.visibility = n == 2;
				
				template().type.val(n);
				template().colorEffects.find(">*").hide();
				template().colorEffects.find(">*:nth-child(" + n + ")").show();
				
			case _:
				hide();
		};
		
		freeze = false;
	}
	
	function type_change(_)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				switch (template().type.val())
				{
					case "0": item.element.colorEffect = null;
					case "1": item.element.colorEffect = new ColorEffectBrightness(0);
					case "2": item.element.colorEffect = new ColorEffectTint("#808080", 0.5);
					case "3": item.element.colorEffect = new ColorEffectAdvanced(1, 1, 1, 1, 0, 0, 0, 0);
					case "4": item.element.colorEffect = new ColorEffectAlpha(0.5);
				}
				bind(obj);
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function color_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				cast(item.element.colorEffect, ColorEffectTint).color = e.color;
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function brightness_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				cast(item.element.colorEffect, ColorEffectBrightness).value = e.value / 100;
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function tint_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				cast(item.element.colorEffect, ColorEffectTint).multiplier = e.value / 100;
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function alpha_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				cast(item.element.colorEffect, ColorEffectAlpha).value = e.value / 100;
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function changeAdvanced()
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				var ce = cast(item.element.colorEffect, ColorEffectAdvanced);
				ce.redMultiplier = Std.parseInt(template().colorMulR.val()) / 100;
				ce.redOffset = Std.parseInt(template().colorAddR.val());
				ce.greenMultiplier = Std.parseInt(template().colorMulG.val()) / 100;
				ce.greenOffset = Std.parseInt(template().colorAddG.val());
				ce.blueMultiplier = Std.parseInt(template().colorMulB.val()) / 100;
				ce.blueOffset = Std.parseInt(template().colorAddB.val());
				ce.alphaMultiplier = Std.parseInt(template().colorMulA.val()) / 100;
				ce.alphaOffset = Std.parseInt(template().colorAddA.val());
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function colorMulR_keyup(_) changeAdvanced();
	function colorAddR_keyup(_) changeAdvanced();
	function colorMulG_keyup(_) changeAdvanced();
	function colorAddG_keyup(_) changeAdvanced();
	function colorMulB_keyup(_) changeAdvanced();
	function colorAddB_keyup(_) changeAdvanced();
	function colorMulA_keyup(_) changeAdvanced();
	function colorAddA_keyup(_) changeAdvanced();
	
	function colorMulR_mouseup(_) changeAdvanced();
	function colorAddR_mouseup(_) changeAdvanced();
	function colorMulG_mouseup(_) changeAdvanced();
	function colorAddG_mouseup(_) changeAdvanced();
	function colorMulB_mouseup(_) changeAdvanced();
	function colorAddB_mouseup(_) changeAdvanced();
	function colorMulA_mouseup(_) changeAdvanced();
	function colorAddA_mouseup(_) changeAdvanced();
}