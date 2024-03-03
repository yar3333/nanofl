package components.nanofl.popups.documentpropertiespopup;

import stdlib.Std;
import nanofl.engine.Library;
import nanofl.ide.Application;
import nanofl.ide.DocumentProperties;
import nanofl.ide.libraryitems.SoundItem;
using stdlib.Lambda;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	static var imports =
	{
		"color-selector": components.nanofl.common.color.Code
	};
	
	@inject var app : Application;

    var lastRelatedSoundOptions = "";
	
    public function show()
	{
		template().width.val(app.document.properties.width);
		template().height.val(app.document.properties.height);
		template().backgroundColor.value = app.document.properties.backgroundColor;
		template().framerate.val(app.document.properties.framerate);
		template().scaleMode.val(app.document.properties.scaleMode);
		template().clickToStart.prop("checked", app.document.properties.clickToStart);
		
		var scene = app.document.library.getSceneItem();
		template().autoPlay.prop("checked", scene.autoPlay);
		template().loop.prop("checked", scene.loop);
		template().sceneLinkedClass.val(scene.linkedClass);

        var options = "<option value=''></option>"
            + app.document.library.getItems().filterByType(SoundItem)
                .map(item ->
                {
                    return "<option value='" + item.namePath + "' title='" + item.namePath + "'>" + item.namePath + "</option>";
                })
                .join("");
        if (options != lastRelatedSoundOptions)
        {
            template().relatedSound.html(options);
            lastRelatedSoundOptions = options;
        }
        template().relatedSound.val(scene.relatedSound ?? "");
		
		showPopup();
	}
	
	override function onOK()
	{
		app.document.undoQueue.beginTransaction({ document:true, libraryChangeItems:[Library.SCENE_NAME_PATH] });
		
		app.document.setProperties(new DocumentProperties
		(
			Std.parseInt(template().width.val()),
			Std.parseInt(template().height.val()),
			template().backgroundColor.value,
			Std.parseFloat(template().framerate.val()),
			template().scaleMode.val(),
            template().clickToStart.prop("checked"),
			app.document.properties.publishSettings
		));
		
		var scene = app.document.library.getSceneItem();
		scene.autoPlay = template().autoPlay.prop("checked");
		scene.loop = template().loop.prop("checked");
		scene.linkedClass = template().sceneLinkedClass.val();
		scene.relatedSound = template().relatedSound.val();
		
		app.document.undoQueue.commitTransaction();
	}
}