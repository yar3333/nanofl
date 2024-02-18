package nanofl.ide;

class InjectContainer extends js.injecting.InjectContainer
{
	public function new() 
	{
		super(Globals.injector);
	}
}