package components.nanofl.others.custompropertiespane.item_float;

class Code extends wquery.Component
{
    var title = "";
    var label = "";
    var name = "";
    var minValue = 0.0;
    var maxValue = 0.0;
    var value = 0.0;
    var units = "";
	var onChange = (v:Float) -> {};
	
	function value_change(_) if (onChange != null)
	{
		var v = Std.parseFloat(template().value.val());
		if (v != null) onChange(v);
	}
}