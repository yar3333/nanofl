package components.nanofl.others.statusbar;

import haxe.Timer;

class Code extends wquery.Component
{
	public var text(get, set) : String;
	function get_text() return template().container.html();
	function set_text(text:String) : String
	{
		template().container.html(text);
		template().container.attr("title", text);
		return text;
	}
	
	public function height() : Int return template().container.outerHeight();
}