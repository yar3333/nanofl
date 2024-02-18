package components.nanofl.others.custompropertiespane.item_string;

class Code extends wquery.Component
{
    var title = "";
    var name = "";
    var value = "";
	var onChange = (v:String) -> {};
	
	function value_change(_) if (onChange != null)
	{
		onChange(template().value.val());
	}
}