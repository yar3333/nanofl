package components.nanofl.others.custompropertiespane.item_color;

class Code extends wquery.Component
{
	static var imports =
	{
		"color-selector": components.nanofl.common.color.Code
	};
	
    var title = "";
    var label = "";
    var name = "";
    var value = "";
	var onChange = (v:String) -> {};

    var units = ""; // to skip warning
	
	function init()
	{
		template().colorSelector.value = value;
	}
	
	function value_change(_) if (onChange != null)
	{
		onChange(template().colorSelector.value);
	}
}