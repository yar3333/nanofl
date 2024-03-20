package js.injecting;

extern class Injector implements js.injecting.InjectorRO {
	function new():Void;
	function injectInto(target:Dynamic):Void;
	function getService<T>(type:Class<T>):T;
	function allowNoRttiForClass(type:Class<Dynamic>):Void;
}