package components.nanofl.others.custompropertiespane.item_list;

class Code extends wquery.Component
{
    var title = "";
    var name = "";
    var label = "";
    var options = "";
	var value = "";
	var onChange = (v:String) -> {};

    var units = ""; // unused, just to prevent wquery warning
	
	function init()
	{
		template().value.val(value);
	}
	
	function value_change(_) if (onChange != null) onChange(template().value.val());
}