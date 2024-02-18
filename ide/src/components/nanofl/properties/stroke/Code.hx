package components.nanofl.properties.stroke;

import js.JQuery;
import nanofl.ide.PropertiesObject;

class Code extends components.nanofl.properties.base.Code
{
	static var imports =
	{
		"color-selector": components.nanofl.common.color.Code,
		"gradient-selector": components.nanofl.others.gradientselector.Code,
		"bitmap-selector": components.nanofl.others.bitmapselector.Code,
		"slider": components.nanofl.common.slider.Code
	};
	
	override function init()
	{
		super.init();
		
		template().caps.on("click", ">*", function(e) { new JQuery(e.target).addClass("active").siblings().removeClass("active"); changeProperties(); });
		template().joints.on("click", ">*", function(e) { new JQuery(e.target).addClass("active").siblings().removeClass("active"); changeProperties(); });
	}
	
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, options):
				var hasSelected = figure.hasSelectedEdges();
				
				if (options.strokePane || hasSelected)
				{
					show();
					
					var params = hasSelected
						? figure.getSelectedEdgesStrokeParams()
						: newObjectParams.getStrokeParams();
					
					if (params.type != null)
					{
						template().type.val(params.type);
						template().color.visibility = false;
						template().gradient.hide();
						template().bitmap.hide();
						
						switch (params.type)
						{
							case "solid":
								template().color.visibility = true;
								template().color.value = params.color;
								template().thickness.show();
								
							case "linear":
								template().gradient.show();
								template().gradient.set(params.colors, params.ratios);
								
							case "radial":
								template().gradient.show();
								template().gradient.set(params.colors, params.ratios);
								
							case "bitmap":
								template().bitmap.show();
								template().bitmap.bind(library.getBitmapsAsIde(), params.bitmapPath);
						}
					}
					
					template().type.find(">option[value=none]").toggle(options.noneStroke);
					
					if (params.thickness != null) template().thickness.value = params.thickness;
					if (params.ignoreScale != null) template().ignoreScale.prop("checked", params.ignoreScale);
					
					template().caps.children().removeClass("active");
					template().caps.find(">[data-value=" + params.caps + "]").addClass("active");
					
					template().joints.children().removeClass("active");
					template().joints.find(">[data-value=" + params.joints + "]").addClass("active");
					
					template().miterLimit.value = params.miterLimit != null && params.miterLimit > 0
						? params.miterLimit
						: -1;
					
					template().miterLimit.toggle(params.joints == "miter");
				}
				else
				{
					hide();
				}
				
			case _:
				hide();
		};
	}
	
	function type_change(_)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, _):
				var type = template().type.val();
				var stroke = newObjectParams.getStrokeByType(type);
				if (figure != null)
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedEdgesStroke(stroke);
				}
				else
				{
					newObjectParams.strokeType = type;
				}
				newObjectParams.strokeType = type;
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
				if (figure.hasSelectedEdges())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedEdgesStrokeParams(cast e);
				}
				newObjectParams.setStrokeParams(cast e);
				
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
				if (figure.hasSelectedEdges())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedEdgesStrokeParams(cast params);
				}
				newObjectParams.setStrokeParams(cast params);
				
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
				if (figure.hasSelectedEdges())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedEdgesStrokeParams(cast e);
				}
				newObjectParams.setStrokeParams(cast e);
				
			case _:
		}
		
		fireChangeEvent();
	}
	
	function thickness_change(_) changeProperties();
	
	function ignoreScale_change(_) changeProperties();
	
	function miterLimit_change(_) changeProperties();
	
	function changeProperties()
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.SHAPE(figure, newObjectParams, _):
				var joints = template().joints.find(">.active").data("value");
				
				var params =
				{
					color: template().color.value,
					thickness: template().thickness.value,
					ignoreScale: template().ignoreScale.prop("checked"),
					caps: template().caps.find(">.active").data("value"),
					joints: joints,
					miterLimit: template().miterLimit.value
				};
				if (figure.hasSelectedEdges())
				{
					undoQueue.beginTransaction({ figure:true });
					figure.setSelectedEdgesStrokeParams(params);
				}
				newObjectParams.setStrokeParams(params);
				
				if (joints == "miter") template().miterLimit.show();
				else                   template().miterLimit.hide();
				
			case _:
		}
		
		fireChangeEvent();
	}
}