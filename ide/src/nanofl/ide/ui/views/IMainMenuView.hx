package nanofl.ide.ui.views;

interface IMainMenuView 
{
	function offset(pos: { left:Int, top:Int } ) : Void;
	function update() : Void;
}