package nanofl.ide.preferences;

extern class ApplicationPreferences {
	function new(storage:nanofl.ide.preferences.PreferencesStorage):Void;
	var checkNewVersionPeriod(get, set) : String;
	private function get_checkNewVersionPeriod():String;
	private function set_checkNewVersionPeriod(v:String):String;
	var checkNewVersionLastDate(get, set) : Float;
	private function get_checkNewVersionLastDate():Float;
	private function set_checkNewVersionLastDate(v:Float):Float;
	var recentDocuments(get, set) : String;
	private function get_recentDocuments():String;
	private function set_recentDocuments(v:String):String;
	var previewHeight(get, set) : Int;
	private function get_previewHeight():Int;
	private function set_previewHeight(v:Int):Int;
	var linkID(get, set) : String;
	private function get_linkID():String;
	private function set_linkID(v:String):String;
}