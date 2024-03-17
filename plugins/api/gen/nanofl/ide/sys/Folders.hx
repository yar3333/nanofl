package nanofl.ide.sys;

interface Folders {
	var application(get, never) : String;
	var tools(get, never) : String;
	var temp(get, never) : String;
	var plugins(get, never) : String;
	var userDocuments(get, never) : String;
	var unsavedDocuments(get, never) : String;
}