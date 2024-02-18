package components.nanofl.others.custompropertiestableform;

import wquery.ComponentList;

class Code extends components.nanofl.others.custompropertiespane.Code
{
	override function init() 
	{
        var container = template().container;
		
		ints       = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_int.Code,       this, container);
		floats     = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_float.Code,     this, container);
		sliders    = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_slider.Code,    this, container);
		colors     = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_color.Code,     this, container);
		strings    = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_string.Code,    this, container);
		bools      = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_bool.Code,      this, container);
		lists      = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_list.Code,      this, container);
		delimiters = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_delimiter.Code, this, container);
		infos      = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_info.Code,      this, container);
		files      = cast new ComponentList(components.nanofl.others.custompropertiestableform.item_file.Code,      this, container);
	}
}