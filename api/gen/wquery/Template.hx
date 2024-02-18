package wquery;

extern class Template {
	function new(klass:Class<wquery.Component>):Void;
	var css(default, null) : String;
	var imports(default, null) : Dynamic<wquery.Component>;
	function newDoc():js.html.DocumentFragment;
	static var baseURL : String;
}