package nanofl.ide.ui.menu;

typedef MenuItem = {
	@:optional
	var align : String;
	@:optional
	var command : String;
	@:optional
	var icon : String;
	@:optional
	var id : String;
	@:optional
	var items : Array<nanofl.ide.ui.menu.MenuItem>;
	var name : String;
	@:optional
	var params : Array<Dynamic>;
	@:optional
	var title : String;
	@:optional
	var version : String;
};