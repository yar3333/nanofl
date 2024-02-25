package components.nanofl.popups.symbolpropertiespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var movieClipItem(get, never) : js.JQuery;
	inline function get_movieClipItem() return component.q('#movieClipItem');
	
	public var likeButton(get, never) : js.JQuery;
	inline function get_likeButton() return component.q('#likeButton');
	
	public var framedItem(get, never) : js.JQuery;
	inline function get_framedItem() return component.q('#framedItem');
	
	public var autoPlay(get, never) : js.JQuery;
	inline function get_autoPlay() return component.q('#autoPlay');
	
	public var loop(get, never) : js.JQuery;
	inline function get_loop() return component.q('#loop');
	
	public var spriteSheetableItem(get, never) : js.JQuery;
	inline function get_spriteSheetableItem() return component.q('#spriteSheetableItem');
	
	public var exportAsSprite(get, never) : js.JQuery;
	inline function get_exportAsSprite() return component.q('#exportAsSprite');

	public var meshItem(get, never) : js.JQuery;
	inline function get_meshItem() return component.q('#meshItem');
    
    public var renderAreaSize(get, never) : js.JQuery;
    inline function get_renderAreaSize() return component.q('#renderAreaSize');

    public var loadLights(get, never) : js.JQuery;
    inline function get_loadLights() return component.q('#loadLights');
	
	public var instancableItem(get, never) : js.JQuery;
	inline function get_instancableItem() return component.q('#instancableItem');
	
	public var linkedClass(get, never) : js.JQuery;
	inline function get_linkedClass() return component.q('#linkedClass');
}