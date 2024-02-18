package components.nanofl.popups.sharefordevicespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var linkID(get, never) : js.JQuery;
	inline function get_linkID() return component.q('#linkID');
	
	public var url(get, never) : js.JQuery;
	inline function get_url() return component.q('#url');
	
	public var generateNewLinkID(get, never) : js.JQuery;
	inline function get_generateNewLinkID() return component.q('#generateNewLinkID');
}