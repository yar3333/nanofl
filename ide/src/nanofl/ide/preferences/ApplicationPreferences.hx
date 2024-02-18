package nanofl.ide.preferences;

class ApplicationPreferences
{
	static inline var prefix = "application.";
	
	var storage : PreferencesStorage;
	
	public var checkNewVersionPeriod(get, set) : String;
	function get_checkNewVersionPeriod() return storage.getString(prefix + "checkNewVersionPeriod");
	function set_checkNewVersionPeriod(v) return storage.set(prefix + "checkNewVersionPeriod", v);
	
	public var checkNewVersionLastDate(get, set) : Float;
	function get_checkNewVersionLastDate() return storage.getFloat(prefix + "checkNewVersionLastDate");
	function set_checkNewVersionLastDate(v) return storage.set(prefix + "checkNewVersionLastDate", v);
	
	public var recentDocuments(get, set) : String;
	function get_recentDocuments() return storage.getString(prefix + "recentDocuments");
	function set_recentDocuments(v) return storage.set(prefix + "recentDocuments", v);
	
	public var previewHeight(get, set) : Int;
	function get_previewHeight() return storage.getInt(prefix + "previewHeight");
	function set_previewHeight(v) return storage.set(prefix + "previewHeight", v);
	
	public var linkID(get, set) : String;
	function get_linkID() return storage.getString(prefix + "linkID");
	function set_linkID(v) return storage.set(prefix + "linkID", v);
	
	#if !no_trial
	public var registered(get, set) : Bool;
	function get_registered() return storage.getBool(prefix + "registered", false);
	function set_registered(v) return storage.set(prefix + "registered", v);
	
	public var firstStartTime(get, set) : Float;
	function get_firstStartTime() return storage.getFloat(prefix + "firstStartTime", 0);
	function set_firstStartTime(v) return storage.set(prefix + "firstStartTime", v);
	
	public var key(get, set) : String;
	function get_key() return storage.getString(prefix + "key");
	function set_key(v) return storage.set(prefix + "key", v);
	#end
	
	public function new(storage:PreferencesStorage) 
	{
		this.storage = storage;
	}
}
