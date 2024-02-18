package wquery;

extern class ComponentTools {
	static function processSubstitutions(doc:js.html.DocumentFragment, object:Dynamic):js.html.DocumentFragment;
	static function expandDocElemIDs(prefixID:String, baseNode:wquery.GenericHtmlElement):Void;
	static function htmlStringToDocumentFragment(html:String):js.html.DocumentFragment;
	static function documentFragmentToHtmlStringTo(doc:js.html.DocumentFragment):String;
	static function createChildren(parent:wquery.Component, node:wquery.GenericHtmlElement, imports:Dynamic<wquery.Component>):Array<wquery.Component>;
	static function loadFieldValues(component:wquery.Component, params:Dynamic):Void;
	static function callMethodIfExists(obj:Dynamic, methodName:String, ?args:Array<Dynamic>):Void;
	static function ensureStylesActive(klassName:String, css:String):Void;
	static function createStyleElement(styleBlockID:String, css:String):js.html.StyleElement;
	static function getClassName(klass:Class<wquery.Component>):String;
	static function callMethodFromParentToChildren(parent:wquery.Component, methodName:String):Void;
	static function callMethodFromChildrenToParent(parent:wquery.Component, methodName:String):Void;
}