package nanofl.ide.preferences;

@:rtti
class Preferences
{
	public var storage : PreferencesStorage;
	
	public var application(default, null) : ApplicationPreferences;
	
	public function new(storage:PreferencesStorage) 
	{
		this.storage = storage;
		
		application = new ApplicationPreferences(storage);
	}
}
