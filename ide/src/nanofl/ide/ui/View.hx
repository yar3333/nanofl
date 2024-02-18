package nanofl.ide.ui;

import nanofl.ide.ui.views.*;

private typedef Container =
{
	function getTemplate() :
	{
		var mainMenu(get, never) : IMainMenuView;
		var movie(get, never) : MovieView;
		var library(get, never) : LibraryView;
		var properties(get, never) : PropertiesView;
		var waiter(get, never) : Waiter;
		var shadow(get, never) : Shadow;
		var alerter(get, never) : Alerter;
		var fpsMeter(get, never) : FpsMeter;
		var output(get, never) : IOutputView;
		var startPageComponent(get, never) : StartPage;
	};
}

@:rtti
class View
{
	@:noapi
	var container : Container;
	
	public var mainMenu(get, never) : IMainMenuView;
	function get_mainMenu() return container.getTemplate().mainMenu;
	
	public var movie(get, never) : MovieView;
	function get_movie() return container.getTemplate().movie;
	
	public var library(get, never) : LibraryView;
	function get_library() return container.getTemplate().library;
	
	public var properties(get, never) : PropertiesView;
	function get_properties() return container.getTemplate().properties;
	
	public var waiter(get, never) : Waiter;
	function get_waiter() return container.getTemplate().waiter;
	
	public var shadow(get, never) : Shadow;
	function get_shadow() return container.getTemplate().shadow;
	
	public var alerter(get, never) : Alerter;
	function get_alerter() return container.getTemplate().alerter;
	
	public var fpsMeter(get, never) : FpsMeter;
	function get_fpsMeter() return container.getTemplate().fpsMeter;
	
	public var output(get, never) : IOutputView;
	function get_output() return container.getTemplate().output;
	
	public var startPage(get, never) : StartPage;
	function get_startPage() return container.getTemplate().startPageComponent;
	
	@:noapi
	public function new(container:Container)
	{
		this.container = container;
	}
}
