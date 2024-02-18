package components.nanofl.common.waiter;

class Code extends wquery.Component
{
	public function show()
	{
        template().container.show();
	}
	
	public function hide()
	{
		template().container.hide();
	}
}