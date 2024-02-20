package wquery;

extern class ComponentList<T:(wquery.Component)> {
	function new(type:Class<T>, parentComponent:wquery.Component, parentNode:js.JQuery, ?paramsList:Array<Dynamic>):Void;
	var length(default, null) : Int;
	function create(?params:Dynamic, ?append:Bool):T;
	function remove(item:T):Bool;
	function clear():Void;
	function iterator():Iterator<T>;
	function getByIndex(n:Int):T;
}