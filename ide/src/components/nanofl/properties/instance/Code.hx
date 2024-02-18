package components.nanofl.properties.instance;

import js.JQuery;
import nanofl.ide.PropertiesObject;
using StringTools;

#if profiler @:build(Profiler.buildMarked()) #end
class Code extends components.nanofl.properties.base.Code
{
	var namePathWidth(get, null) : Int;
	function get_namePathWidth()
	{
		if (namePathWidth == null)
		{
			namePathWidth = template().namePath.width();
		}
		return namePathWidth;
	}
	
	var lastOptions : String;

	@:profile
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				show();
				template().namePathContainer.show();
				
				template().name.val(item.element.name);
				
				var templateNamePath = template().namePath;
				var width = namePathWidth - scrollBarWidth;
				
				var options = library.getItemsAsIde()
					.filter(item -> editor.isItemCanBeAdded(item))
					.map(function(item)
					{
						return "<option value='" + item.namePath + "' style='width:" + width + "px' title='" + item.namePath + "'>" + item.namePath + "</option>";
					})
					.join("");
				
				if (options != lastOptions)
				{
					templateNamePath.html(options);
					lastOptions = options;
				}
				templateNamePath.val(item.element.namePath);
				
			case PropertiesObject.TEXT(item, _):
				if (item != null)
				{
					show();
					template().namePathContainer.hide();
					
					template().name.val(item.element.name);
				}
				else
				{
					hide();
				}
				
			case _:
				hide();
		};
	}
	
	function name_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				if (item.element.name != template().name.val().trim())
				{
					undoQueue.beginTransaction({ element:item.element });
					item.element.name = template().name.val().trim();
					undoQueue.commitTransaction();
				}
			
			case PropertiesObject.TEXT(item, _):
				if (item.element.name != template().name.val().trim())
				{
					undoQueue.beginTransaction({ element:item.element });
					item.element.name = template().name.val().trim();
					undoQueue.commitTransaction();
				}
				
			case _:
		}
	}
	
	function namePath_change(e)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				editor.swapInstance(item.element, template().namePath.val());
				
			case _:
		}
	}
}