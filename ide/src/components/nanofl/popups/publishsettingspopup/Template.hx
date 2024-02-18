package components.nanofl.popups.publishsettingspopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var useTextureAtlases(get, never) : js.JQuery;
	inline function get_useTextureAtlases() return component.q('#useTextureAtlases');
	
	public var manageTextureAtlases(get, never) : js.JQuery;
	inline function get_manageTextureAtlases() return component.q('#manageTextureAtlases');
	
	public var isConvertImagesIntoJpeg(get, never) : js.JQuery;
	inline function get_isConvertImagesIntoJpeg() return component.q('#isConvertImagesIntoJpeg');
	
	public var jpegQuality(get, never) : js.JQuery;
	inline function get_jpegQuality() return component.q('#jpegQuality');
	
	public var isGenerateMp3Sounds(get, never) : js.JQuery;
	inline function get_isGenerateMp3Sounds() return component.q('#isGenerateMp3Sounds');
	
	public var isGenerateOggSounds(get, never) : js.JQuery;
	inline function get_isGenerateOggSounds() return component.q('#isGenerateOggSounds');
	
	public var isGenerateWavSounds(get, never) : js.JQuery;
	inline function get_isGenerateWavSounds() return component.q('#isGenerateWavSounds');
	
	public var audioQuality(get, never) : js.JQuery;
	inline function get_audioQuality() return component.q('#audioQuality');
	
	public var urlOnClick(get, never) : js.JQuery;
	inline function get_urlOnClick() return component.q('#urlOnClick');
	
	public var useLocalScripts(get, never) : js.JQuery;
	inline function get_useLocalScripts() return component.q('#useLocalScripts');
	
	//public var shareForDevices(get, never) : js.JQuery;
	//inline function get_shareForDevices() return component.q('#shareForDevices');
	
	//public var showShareForDevicesPopup(get, never) : js.JQuery;
	//inline function get_showShareForDevicesPopup() return component.q('#showShareForDevicesPopup');
	
	public var publish(get, never) : js.JQuery;
	inline function get_publish() return component.q('#publish');
}