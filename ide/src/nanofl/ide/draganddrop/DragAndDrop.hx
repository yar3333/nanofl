package nanofl.ide.draganddrop;

import js.lib.Promise;

@:rtti
class DragAndDrop
{
	var resolve : IDragAndDrop->Void;
	
	public var ready(default, null) : Promise<IDragAndDrop>;
	
	public function new()
	{
		ready = new Promise<IDragAndDrop>(function(resolve, reject)
		{
			this.resolve = resolve;
		});
	}
	
	@:allow(components.nanofl.page.Code)
	function init(container:IDragAndDrop)
	{
		resolve(container);
	}
}
