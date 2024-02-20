package nanofl.ide.ui.views;

interface IMainMenuView {
	function offset(pos:{ var left : Int; var top : Int; }):Void;
	function update():Void;
}