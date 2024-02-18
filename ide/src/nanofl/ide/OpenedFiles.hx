package nanofl.ide;

import js.lib.Promise;

private typedef Container =
{
	function getTemplate() :
	{
		var openedFiles(get, never) : components.nanofl.others.openedfiles.Code;
	};
}

@:rtti
class OpenedFiles
{
	@:noapi
	var container : Container;
	
	public var active(get, never) : OpenedFile;
	function get_active() return container.getTemplate().openedFiles.active;
	
	public var length(get, never) : Int;
	function get_length() : Int return container.getTemplate().openedFiles.length;
	
	public function iterator() : Iterator<OpenedFile> return container.getTemplate().openedFiles.iterator();
	public function closeAll(?force:Bool) : Promise<{}> return container.getTemplate().openedFiles.closeAll(force);
	
	@:allow(nanofl.ide.Document)
	@:allow(nanofl.ide.coding.CodeFile)
	private function add(doc:OpenedFile) : Void container.getTemplate().openedFiles.add(doc);
	
	@:allow(nanofl.ide.OpenedFile.close)
	private function close(doc:OpenedFile) : Void container.getTemplate().openedFiles.close(doc);
	
	@:allow(nanofl.ide.Document.activate)
	@:allow(nanofl.ide.coding.CodeFile.activate)
	private function activate(id:String) : Void container.getTemplate().openedFiles.activate(id);
	
	@:allow(nanofl.ide.OpenedFile)
	private function titleChanged(doc:OpenedFile) : Void container.getTemplate().openedFiles.titleChanged(doc);
	
	@:noapi
	public function new(container:Container)
	{
		this.container = container;
	}
}