package components.nanofl.others.custompropertiespane.item_int;

class Code extends wquery.Component
{
    var title = "";
    var label = "";
    var name = "";
    var minValue = 0;
    var maxValue = 0;
    var value = 0;
    var units = "";
	var onChange = (v:Int) -> {};
	
	function value_change(_) if (onChange != null)
	{
		var v = Std.parseInt(template().value.val());
		if (v != null) onChange(v);
	}
}