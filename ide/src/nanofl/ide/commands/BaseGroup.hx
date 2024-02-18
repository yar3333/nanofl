package nanofl.ide.commands;

@:rtti
class BaseGroup extends InjectContainer
{
	@inject var app : Application;
	
	function tempActiveView(view:ActiveView, callb:Void->Void) : Void
	{
		var saved = app.activeView;
		app.activeView = view;
		
		callb();
		
		app.activeView = saved;
	}
}
