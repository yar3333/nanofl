package components.nanofl.others.custompropertiespane.item_slider;

class Code extends wquery.Component
{
	static var imports =
	{
		"slider": components.nanofl.common.slider.Code
	};

    var title = ""; // not used in code; just to suppress warning
    var name = "";
    var label = "";
    var minValue = 0.0;
    var maxValue = 0.0;
    var units = "";

    var initValue = null;
    
    var value(get, set): Float;
    function get_value()  return template().slider != null ? template().slider.value : 0.0;
    function set_value(v) return template().slider != null ? template().slider.value = v : initValue = v;
	
    var onChange = (v:Float) -> {};

    function init()
    {
        if (initValue != null) template().slider.value = initValue;
    }
	
	function slider_change(e:{ value:Float }) if (onChange != null) onChange(e.value);
}