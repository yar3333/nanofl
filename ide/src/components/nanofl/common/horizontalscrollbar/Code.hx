package components.nanofl.common.horizontalscrollbar;

class Code extends wquery.Component
{
	var event_change = new wquery.Event<{ position:Int }>();
	
	public var position(get, set) : Int;
	public var size(get, set) : Int;
	
	function init()
	{
		template().bar.bind("scroll", function(e) event_change.emit({ position:position }));
	}
	
	function get_position() : Int
	{
		return template().bar.scrollLeft();
	}
	
	function set_position(p:Int) : Int
	{
		template().bar.scrollLeft(p);
		return p;
	}
	
	function get_size() : Int
	{
		return template().bar.find(">div").width();
	}
	
	function set_size(v:Int) : Int
	{
		template().bar.find(">div").width(v);
		return v;
	}
}