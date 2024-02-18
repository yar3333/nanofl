package nanofl.ide.draganddrop;

enum abstract AllowedDropEffect(String) to String
{
	var copy = "copy";
	var move = "move";
	var copyMove = "copyMove";
}