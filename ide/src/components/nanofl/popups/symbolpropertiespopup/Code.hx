package components.nanofl.popups.symbolpropertiespopup;

import js.JQuery;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.engine.libraryitems.MeshItem;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.ide.Application;
import nanofl.ide.ISymbol;
import stdlib.Std;
using stdlib.Lambda;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var app : Application;
    
	var item : ISymbol;

    var lastRelatedSoundOptions = "";
	
	public function show(item:ISymbol)
	{
		this.item = item;
        
        getSection(template().loop).hide();
        getSection(template().autoPlay).hide();
        getSection(template().likeButton).hide();
        getSection(template().relatedSound).hide();
        getSection(template().exportAsSprite).hide();
        getSection(template().linkedClass).hide();
        template().meshItem.hide();

        if (Std.isOfType(item, MovieClipItem))
        {
            final mcItem : MovieClipItem = cast item;

            getSection(template().autoPlay).show();
            template().autoPlay.prop("checked", mcItem.autoPlay);

            getSection(template().loop).show();
            template().loop.prop("checked", mcItem.loop);

            getSection(template().likeButton).show();
            template().likeButton.prop("checked", mcItem.likeButton);
        
            getSection(template().relatedSound).show();
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
            template().relatedSound.val(mcItem.relatedSound ?? "");

            getSection(template().exportAsSprite).show();
            template().exportAsSprite.prop("checked", mcItem.exportAsSprite);
        }

        if (Std.isOfType(item, InstancableItem))
		{
            getSection(template().linkedClass).show();
			template().linkedClass.val(item.linkedClass);
		}

		if (Std.isOfType(item, MeshItem))
        {
            template().meshItem.show();
            template().renderAreaSize.val((cast item:MeshItem).renderAreaSize);
            template().loadLights.prop("checked", (cast item:MeshItem).loadLights);
        }
		
		showPopup();
	}
	
	override function onOK()
	{
		app.document.undoQueue.beginTransaction({ libraryChangeItems:[item.namePath] });
		
		if (Std.isOfType(item, MovieClipItem))
		{
            final mcItem : MovieClipItem = cast item;

			mcItem.likeButton = template().likeButton.prop("checked");
			mcItem.relatedSound = template().relatedSound.val();
			mcItem.autoPlay = template().autoPlay.prop("checked");
			mcItem.loop = template().loop.prop("checked");
			mcItem.exportAsSprite = template().exportAsSprite.prop("checked");
		}
		
		item.linkedClass = template().linkedClass.val();
		
		if (Std.is(item, MeshItem))
        {
            (cast item:MeshItem).renderAreaSize = Std.parseInt(template().renderAreaSize.val(), MeshItem.DEFAULT_RENDER_AREA_SIZE);
            (cast item:MeshItem).loadLights = template().loadLights.prop("checked");
        }
        
        app.document.undoQueue.commitTransaction();
		
		app.document.library.update();
		
		app.document.editor.rebind();
	}

    static function getSection(elem:JQuery) : JQuery
    {
        while (elem[0].tagName != "TR") elem = elem.parent();
        return elem;
    }
}