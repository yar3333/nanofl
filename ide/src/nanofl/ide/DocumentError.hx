package nanofl.ide;

class DocumentError
{
	public var message: String;
	
	public function new(message:String) 
	{
		this.message = message;
	}
	
	function toString() return message;
}