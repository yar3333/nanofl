package nanofl.ide.preferences;

@:rtti
class Preferences extends InjectContainer 
{
	@inject public var storage(default, null) : PreferencesStorage;
	
    public final application : ApplicationPreferences;
	
	public function new() 
	{
        super();
		this.application = new ApplicationPreferences(storage);
	}
}
