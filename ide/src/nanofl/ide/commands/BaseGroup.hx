package nanofl.ide.commands;

@:rtti
class BaseGroup extends InjectContainer
{
	@inject var app : Application;
	
	function tempActiveView(view:ActiveView, callb:Void->Void) : Void
	{
		final saved = app.activeView;
		app.setActiveView(view, null);
		
		callb();
		
		app.setActiveView(saved, null);
	}
}
