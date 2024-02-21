package wquery;

extern class ComponentTools {
	static function processSubstitutions(doc:js.html.TemplateElement, object:Dynamic):Void;
	static function expandDocElemIDs(prefixID:String, baseNode:js.html.Element):Void;
	static function createChildren(parent:wquery.Component, node:js.html.DocumentFragment, imports:Dynamic<wquery.Component>):Array<wquery.Component>;
	static function loadFieldValues(component:wquery.Component, params:Dynamic):Void;
	static function callMethodIfExists(obj:Dynamic, methodName:String, ?args:Array<Dynamic>):Void;
	static function ensureStylesActive(klassName:String, css:String):Void;
	static function createStyleElement(styleBlockID:String, css:String):js.html.StyleElement;
	static function getClassName(klass:Class<wquery.Component>):String;
	static function callMethodFromParentToChildren(parent:wquery.Component, methodName:String):Void;
	static function callMethodFromChildrenToParent(parent:wquery.Component, methodName:String):Void;
}