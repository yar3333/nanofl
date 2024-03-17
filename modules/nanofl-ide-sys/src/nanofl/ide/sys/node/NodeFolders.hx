package nanofl.ide.sys.node;

import nanofl.ide.sys.node.core.ElectronApi;
import haxe.io.Path;

class NodeFolders implements Folders
{
	var environment : Environment;
	
	public function new(environment:Environment)
	{
		this.environment = environment;
	}
	
	public var application(get, never) : String;
	function get_application() return Path.directory(ElectronApi.getVar("process", "argv")[0]);
	
	public var tools(get, never) : String;
	function get_tools() return application + "/tools";
	
	public var temp(get, never) : String;
	function get_temp() return environment.get("temp") + "/nanofl";
	
	public var plugins(get, never) : String;
	function get_plugins() return application + "/plugins";
	
	public var userDocuments(get, never) : String;
	function get_userDocuments() return environment.get("USERPROFILE") + "/Documents";

    public var unsavedDocuments(get, never) : String;
    function get_unsavedDocuments() return temp + "/unsaved";
}