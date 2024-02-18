package nanofl.ide.sys.node;

import nanofl.ide.sys.node.core.ElectronApi;

class ElectronMainProcess implements nanofl.ide.sys.MainProcess
{
    public function new() {}

    public function getCommandLineArgs() : Array<String>
    {
        return ElectronApi.getVar("process", "argv").slice(1);
    }
}
