package components.nanofl.movie.timelinelayer;

import js.JQuery;
import wquery.Event;
using js.jquery.Editable;

class Code extends wquery.Component
{
	public var selected(get, never) : Bool;
	function get_selected() return template().layerRow.hasClass("selected");

	public var event_iconClick = new Event<JqEvent>();
	public var event_titleClick = new Event<JqEvent>();
	public var event_editedClick = new Event<JqEvent>();
	public var event_visibleClick = new Event<JqEvent>();
	public var event_lockedClick = new Event<JqEvent>();

	var layerCssClass = "";
	var iconCssClass = "";
	var title = "";
	var layerVisibleCssClass = "";
	var layerLockedCssClass = "";
	
	public function beginEditTitle()
	{
		template().title.beginEdit();
	}
	
	function icon_click(e) event_iconClick.emit(e);
	function title_click(e) event_titleClick.emit(e);
	function edited_click(e) event_editedClick.emit(e);
	function visible_click(e) event_visibleClick.emit(e);
	function locked_click(e) event_lockedClick.emit(e);
}