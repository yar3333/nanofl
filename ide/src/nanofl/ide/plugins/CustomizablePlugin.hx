package nanofl.ide.plugins;

import nanofl.engine.CustomProperty;

typedef CustomizablePlugin =
{
	var name : String;
	var menuItemName : String;
	var menuItemIcon : String;
	var properties : Array<CustomProperty>;
}