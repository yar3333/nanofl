package nanofl.ide.preferences;

extern class Preferences {
	function new(storage:nanofl.ide.preferences.PreferencesStorage):Void;
	var storage : nanofl.ide.preferences.PreferencesStorage;
	var application(default, null) : nanofl.ide.preferences.ApplicationPreferences;
}