package nanofl.engine;

interface AdvancableDisplayObject {
	function advance():js.lib.Promise<{ }>;
}