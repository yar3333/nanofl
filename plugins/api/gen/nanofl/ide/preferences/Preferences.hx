package nanofl.ide.preferences;

extern class Preferences extends nanofl.ide.InjectContainer {
	function new():Void;
	var storage(default, null) : nanofl.ide.preferences.PreferencesStorage;
	var application : nanofl.ide.preferences.ApplicationPreferences;
}