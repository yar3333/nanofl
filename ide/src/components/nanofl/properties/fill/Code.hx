package components.nanofl.properties.fill;

import nanofl.ide.PropertiesObject;

class Code extends components.nanofl.properties.base.Code
{
	static var imports =
	{
		"color-selector": components.nanofl.common.color.Code,
		"gradient-selector": components.nanofl.others.gradientselector.Code,
		"bitmap-selector": components.nanofl.others.bitmapselector.Code
	};
	
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, options):
				var hasSelected = figure.hasSelectedPolygons();
				
				if (options.fillPane || hasSelected)
				{
					show();
					
					var params = hasSelected
						? figure.getSelectedPolygonsFillParams()
						: newObjectParams.getFillParams();
					
					if (params.type != null)
					{
						template().type.val(params.type);
						template().color.visibility = false;
						template().gradient.hide();
						template().bitmap.hide();
						template().repeatContainer.hide();
						
						switch (params.type)
						{
							case "solid":
								template().color.visibility = true;
								template().color.value = params.color;
								
							case "linear":
								template().gradient.show();
								template().gradient.set(params.colors, params.ratios);
								
							case "radial":
								template().gradient.show();
								template().gradient.set(params.colors, params.ratios);
								
							case "bitmap":
								template().bitmap.show();
								template().bitmap.bind(library.getBitmapsAsIde(), params.bitmapPath);
								template().repeatContainer.show();
								template().repeat.prop("checked", params.repeat != "no-repeat");
						}
						
						template().type.find(">option[value=none]").toggle(options.noneFill);
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
	
	function type_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, _):
				var type = template().type.val();
				var fill = newObjectParams.getFillByType(type);
				if (figure.hasSelectedPolygons())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedPolygonsFill(fill);
				}
				newObjectParams.fillType = type;
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
			case PropertiesObject.SHAPE(figure, newObjectParams, _):
				if (figure.hasSelectedPolygons())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedPolygonsFillParams(cast e);
				}
				newObjectParams.setFillParams(cast e);
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function gradient_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, _):
				var gradient = template().gradient;
				var params = gradient.get();
				if (figure.hasSelectedPolygons())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedPolygonsFillParams(cast params);
				}
				newObjectParams.setFillParams(cast params);
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function bitmap_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, _):
				if (figure.hasSelectedPolygons())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedPolygonsFillParams(cast e);
				}
				newObjectParams.setFillParams(cast e);
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function repeat_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, _):
				var repeat = template().repeat.prop("checked") ? "repeat" : "no-repeat";
				if (figure.hasSelectedPolygons())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedPolygonsFillParams({ repeat:repeat });
				}
				newObjectParams.setFillParams({ repeat:repeat });
				
			case _:
		}
		
		fireChangeEvent();
	}
}