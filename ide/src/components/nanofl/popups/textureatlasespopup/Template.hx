package components.nanofl.popups.textureatlasespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var libraryContainer(get, never) : js.JQuery;
	inline function get_libraryContainer() return component.q('#libraryContainer');
	
	public var library(get, never) : components.nanofl.library.libraryview.Code;
	inline function get_library() return cast component.children.library;
	
	public var toAtlas(get, never) : js.JQuery;
	inline function get_toAtlas() return component.q('#toAtlas');
	
	public var fromAtlas(get, never) : js.JQuery;
	inline function get_fromAtlas() return component.q('#fromAtlas');
	
	public var atlases(get, never) : js.JQuery;
	inline function get_atlases() return component.q('#atlases');
	
	public var newAtlas(get, never) : js.JQuery;
	inline function get_newAtlas() return component.q('#newAtlas');
	
	public var atlasProperties(get, never) : js.JQuery;
	inline function get_atlasProperties() return component.q('#atlasProperties');
	
	public var deleteAtlas(get, never) : js.JQuery;
	inline function get_deleteAtlas() return component.q('#deleteAtlas');
	
	public var atlasContainer(get, never) : js.JQuery;
	inline function get_atlasContainer() return component.q('#atlasContainer');
	
	public var atlas(get, never) : components.nanofl.library.libraryview.Code;
	inline function get_atlas() return cast component.children.atlas;
}