package nanofl.ide;

extern class CommandLine extends nanofl.ide.InjectContainer {
	static function process():js.lib.Promise<Bool>;
}