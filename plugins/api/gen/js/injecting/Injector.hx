package js.injecting;

extern class Injector implements js.injecting.InjectorRO {
	function new():Void;
	function map<T>(type:Class<T>, object:T):Void;
	function injectInto(target:Dynamic):Void;
	function allowNoRttiForClass(type:Class<Dynamic>):Void;
}