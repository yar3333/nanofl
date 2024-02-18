package nanofl.ide.ui.menu;

typedef MenuItem =
{
	var name : String;
	@:optional var command : String;
	@:optional var params : Array<Dynamic>;
	@:optional var icon : String;
	@:optional var title : String;
	@:optional var align : String;
	@:optional var version : String;
	@:optional var id : String;
	@:optional var items : Array<MenuItem>;
}