package nanofl.ide.plugins;

extern class PluginApi extends nanofl.ide.InjectContainer {
	@inject
	var fileSystem : nanofl.ide.sys.FileSystem;
	@inject
	var processManager : nanofl.ide.sys.ProcessManager;
	@inject
	var environment : nanofl.ide.sys.Environment;
	@inject
	var folders : nanofl.ide.sys.Folders;
	@inject
	var zip : nanofl.ide.sys.Zip;
	@inject
	var fonts : nanofl.ide.sys.Fonts;
}