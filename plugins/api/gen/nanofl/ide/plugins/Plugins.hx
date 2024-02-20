package nanofl.ide.plugins;

extern class Plugins extends nanofl.ide.InjectContainer {
	function new():Void;
	function reload(?alertOnSuccess:Bool):js.lib.Promise<{ }>;
}