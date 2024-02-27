package nanofl.ide.sys;

import js.injecting.Injector;

class SysStuff
{
    public static function registerInInjector(injector:Injector) : Void
    {
        var fileSystem = new nanofl.ide.sys.node.NodeFileSystem();
        var processManager = new nanofl.ide.sys.node.NodeProcessManager();
        var environment = new nanofl.ide.sys.node.NodeEnvironment();
        var folders = new nanofl.ide.sys.node.NodeFolders(environment);
        
		injector.map(FileSystem, fileSystem);
		injector.map(Environment, environment);
		injector.map(Folders, folders);
		injector.map(ProcessManager, processManager);
		injector.map(HttpUtils, new nanofl.ide.sys.node.NodeHttpUtils());
		injector.map(Zip, new nanofl.ide.sys.node.NodeZip(fileSystem, processManager, folders));
		injector.map(Shell, new nanofl.ide.sys.node.NodeShell(fileSystem, processManager, environment));
		injector.map(WebServerUtils, new nanofl.ide.sys.node.NodeWebServerUtils());
		injector.map(Uploader, new nanofl.ide.sys.Uploader(fileSystem));
		injector.map(Fonts, new nanofl.ide.sys.node.NodeFonts());

        injector.map(MainProcess, new nanofl.ide.sys.node.ElectronMainProcess());
        injector.map(Clipboard, new nanofl.ide.sys.node.ElectronClipboard());
        injector.map(Dialogs, new nanofl.ide.sys.node.ElectronDialogs());
    }
}