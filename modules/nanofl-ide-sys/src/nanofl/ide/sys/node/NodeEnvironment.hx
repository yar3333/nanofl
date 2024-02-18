package nanofl.ide.sys.node;

import nanofl.ide.sys.node.core.ElectronApi;

class NodeEnvironment implements nanofl.ide.sys.Environment
{
	public function new() {}
    
	public function get(name:String) : String
	{
		return ElectronApi.getEnvVar(name);
	}
}