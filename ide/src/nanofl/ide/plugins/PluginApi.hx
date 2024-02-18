package nanofl.ide.plugins;

class PluginApi extends InjectContainer
{
	@inject public var fileSystem : nanofl.ide.sys.FileSystem;
	@inject public var processManager : nanofl.ide.sys.ProcessManager;
	@inject public var environment : nanofl.ide.sys.Environment;
	@inject public var folders : nanofl.ide.sys.Folders;
	@inject public var zip : nanofl.ide.sys.Zip;
	@inject public var fonts : nanofl.ide.sys.Fonts;

    @:noapi public function new() super();
}
