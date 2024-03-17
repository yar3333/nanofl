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
        
		injector.addSingleton(FileSystem, fileSystem);
		injector.addSingleton(ProcessManager, processManager);
		injector.addSingleton(Environment, environment);
		injector.addSingleton(Folders, folders);
		
        injector.addSingleton(HttpUtils, new nanofl.ide.sys.node.NodeHttpUtils());
		injector.addSingleton(Zip, new nanofl.ide.sys.node.NodeZip(fileSystem, processManager, folders));
		injector.addSingleton(Shell, new nanofl.ide.sys.node.NodeShell(fileSystem, processManager, environment));
		injector.addSingleton(WebServerUtils, new nanofl.ide.sys.node.NodeWebServerUtils());
		injector.addSingleton(Uploader, new nanofl.ide.sys.Uploader(fileSystem));
		injector.addSingleton(Fonts, new nanofl.ide.sys.node.NodeFonts());
		injector.addSingleton(VideoUtils, new nanofl.ide.sys.node.NodeVideoUtils(processManager, folders));

        injector.addSingleton(MainProcess, new nanofl.ide.sys.node.ElectronMainProcess());
        injector.addSingleton(Clipboard, new nanofl.ide.sys.node.ElectronClipboard());
        injector.addSingleton(Dialogs, new nanofl.ide.sys.node.ElectronDialogs());
    }
}