package components.nanofl.properties.filters;

import nanofl.engine.FilterDef;
import nanofl.engine.plugins.FilterPlugins;
import nanofl.ide.PropertiesObject;
import stdlib.Std;
using stdlib.Lambda;

class Code extends components.nanofl.properties.base.Code
{
	static var imports =
	{
		"custom-properties-pane": components.nanofl.others.custompropertiespane.Code
	};

	override function init()
	{
		template().allFilters.on("click", ">li>a", function(e)
		{
			switch (obj)
			{
				case PropertiesObject.INSTANCE(item):
					var name = q(e.currentTarget).attr("data-name");
					
					undoQueue.beginTransaction({ element:item.originalElement });
					
					item.element.filters.push(new FilterDef(name, {}));
					rebind(true);
                    
                    template().usedFilters.val(item.element.filters.length - 1);
                    rebind(false);
					
					undoQueue.commitTransaction();
					
					fireChangeEvent();
					
				case _:
			}
		});
		
		super.init();
	}
	
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(_):
				show();
				
				var filters = FilterPlugins.plugins.sorted((a, b) -> Reflect.compare(a.label, b.label));
				template().allFilters.html(filters.map(f -> "<li><a href='javascript:void(0)' data-name='" + f.name + "'>" + f.label + "</a></li>").join(""));
				rebind(true);
				
			case _:
				hide();
		};
	}
	
	function rebind(updateUsedFilters:Bool)
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				if (updateUsedFilters)
				{
					template().usedFilters.html(item.element.filters.mapi((i, f) -> "<option value='" + i + "'>" + f.getLabel() + "</option>").join(""));
				}
				
				template().customProperties.clear();
				
				var filter = getActiveFilter();
				if (filter != null)
				{
					template().customProperties.bind(filter.getProperties(), filter.params);
				}
				
			case _:
		}
	}
	
	function usedFilters_click(e) rebind(false);
	
	function customProperties_preChange(_)
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				undoQueue.beginTransaction({ element:item.originalElement });
				
			case _:
		}
	}
	
	function customProperties_change(_) fireChangeEvent();
	
	override function fireChangeEvent()
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				item.update();
				
			case _:
		}
		
		super.fireChangeEvent();
	}
	
	function removeFilter_click(e)
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				final s = template().usedFilters.val();
				if (s == null) return;
				
				undoQueue.beginTransaction({ element:item.originalElement });
				
                final n = Std.parseInt(s);
				item.element.filters.splice(n, 1);

				rebind(true);
				
				undoQueue.commitTransaction();
				
				fireChangeEvent();
				
			case _:
		}
	}
	
	function getActiveFilter() : FilterDef
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):
				final s = template().usedFilters.val();
				final n = s != null ? Std.parseInt(s) : null;
				return n != null && n < item.element.filters.length ? item.element.filters[n] : null;
				
			case _:
		}
		return null;
	}
}