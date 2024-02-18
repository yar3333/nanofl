package wquery;

typedef GenericHtmlElement = {
	var children(default, null) : js.html.HTMLCollection;
	function querySelectorAll(s:String):js.html.NodeList;
};