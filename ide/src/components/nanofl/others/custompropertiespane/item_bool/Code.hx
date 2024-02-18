package components.nanofl.others.custompropertiespane.item_bool;

class Code extends wquery.Component
{
    var label = "";
    var title = "";
    var name = "";
	var value = false;
	var onChange = (v:Bool) -> {};

    var units = ""; // unused, just to prevent wquery warning
	
	function init()
	{
		if (value) template().value.prop("checked", true);
	}
	
	function value_change(_) if (onChange != null)
	{
		onChange(template().value.is(":checked"));
	}
}