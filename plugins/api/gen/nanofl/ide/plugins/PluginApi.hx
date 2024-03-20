package nanofl.ide.plugins;

extern class PluginApi extends nanofl.ide.InjectContainer {
	var fileSystem : nanofl.ide.sys.FileSystem;
	var processManager : nanofl.ide.sys.ProcessManager;
	var environment : nanofl.ide.sys.Environment;
	var folders : nanofl.ide.sys.Folders;
	var zip : nanofl.ide.sys.Zip;
	var fonts : nanofl.ide.sys.Fonts;
	var httpUtils : nanofl.ide.sys.HttpUtils;
	var mediaUtils : nanofl.ide.sys.MediaUtils;
}