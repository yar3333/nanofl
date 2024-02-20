package components.nanofl.popups.publishsettingspopup;

import nanofl.ide.Application;
import nanofl.ide.ui.Popups;
import nanofl.ide.PublishSettings;
import stdlib.Std;
using stdlib.Lambda;
using StringTools;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	static var imports =
	{
		//"custom-properties-table-form": components.nanofl.others.custompropertiestableform.Code
	};
	
	@inject var app : Application;
	@inject var popups : Popups;

	var settings : PublishSettings;
	
	public function show() 
	{
		settings = app.document.properties.publishSettings.clone();
		
		showPopup();
		
		template().useTextureAtlases.prop("checked", settings.useTextureAtlases);
		useTextureAtlases_change(null);
		
		template().isConvertImagesIntoJpeg.prop("checked", settings.isConvertImagesIntoJpeg);
		template().jpegQuality.val(settings.jpegQuality);
		template().isGenerateMp3Sounds.prop("checked", settings.isGenerateMp3Sounds);
		template().isGenerateOggSounds.prop("checked", settings.isGenerateOggSounds);
		template().isGenerateWavSounds.prop("checked", settings.isGenerateWavSounds);
		template().audioQuality.val(settings.audioQuality);
		template().urlOnClick.prop("checked", settings.urlOnClick);
		template().useLocalScripts.prop("checked", settings.useLocalScripts);
		//template().shareForDevices.prop("checked", settings.shareForDevices);
	}
	
	override function onOK()
	{
		app.document.undoQueue.beginTransaction({ document:true });
		app.document.properties.publishSettings = settings;
		app.document.undoQueue.commitTransaction();
	}
	
	function useTextureAtlases_change(_)
	{
		settings.useTextureAtlases = template().useTextureAtlases.prop("checked");
		template().manageTextureAtlases.prop("disabled", !settings.useTextureAtlases);
	}
	
	function manageTextureAtlases_click(_)
	{
		popups.textureAtlases.show();
	}
	
	function isConvertImagesIntoJpeg_change(_)
	{
		settings.isConvertImagesIntoJpeg = template().isConvertImagesIntoJpeg.prop("checked");
	}
	
	function jpegQuality_change(_)
	{
		settings.jpegQuality = Std.parseInt(template().jpegQuality.val(), 80);
	}
	
	function isGenerateMp3Sounds_change(_)
	{
		settings.isGenerateMp3Sounds = template().isGenerateMp3Sounds.prop("checked");
	}
	
	function isGenerateOggSounds_change(_)
	{
		settings.isGenerateOggSounds = template().isGenerateOggSounds.prop("checked");
	}
	
	function isGenerateWavSounds_change(_)
	{
		settings.isGenerateWavSounds = template().isGenerateWavSounds.prop("checked");
	}
	
	function audioQuality_change(_)
	{
		settings.audioQuality = Std.parseInt(template().audioQuality.val(), 128);
	}
	
	function urlOnClick_change(_)
	{
		settings.urlOnClick = template().urlOnClick.val();
	}
	
	function useLocalScripts_change(_)
	{
		settings.useLocalScripts = template().useLocalScripts.prop("checked");
	}
	
	function publish_click(_)
	{
		ok_click(null);
		app.document.publish();
	}
}