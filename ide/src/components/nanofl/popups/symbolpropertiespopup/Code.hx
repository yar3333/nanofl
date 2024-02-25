package components.nanofl.popups.symbolpropertiespopup;

import nanofl.engine.libraryitems.MeshItem;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.engine.IFramedItem;
import nanofl.engine.ISpriteSheetableItem;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.ide.Application;
import nanofl.ide.ISymbol;
import stdlib.Std;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var app : Application;
    
	var item : ISymbol;
	
	public function show(item:ISymbol)
	{
		this.item = item;
		
		if (Std.isOfType(item, MovieClipItem))
		{
			template().movieClipItem.show();
			template().likeButton.prop("checked", (cast item:MovieClipItem).likeButton);
		}
		else
		{
			template().movieClipItem.hide();
		}
		
		if (Std.isOfType(item, IFramedItem))
		{
			template().framedItem.show();
			template().autoPlay.prop("checked", (cast item:IFramedItem).autoPlay);
			template().loop.prop("checked", (cast item:IFramedItem ).loop);
		}
		else
		{
			template().framedItem.hide();
		}
		
		if (Std.isOfType(item, ISpriteSheetableItem))
		{
			template().spriteSheetableItem.show();
			template().exportAsSprite.prop("checked", (cast item:ISpriteSheetableItem).exportAsSprite);
		}
		else
		{
			template().spriteSheetableItem.hide();
		}
		
		if (Std.isOfType(item, InstancableItem))
		{
			template().instancableItem.show();
			template().linkedClass.val(item.linkedClass);
		}
		else
		{
			template().instancableItem.hide();
		}

		if (Std.isOfType(item, MeshItem))
        {
            template().meshItem.show();
            template().renderAreaSize.val((cast item:MeshItem).renderAreaSize);
            template().loadLights.prop("checked", (cast item:MeshItem).loadLights);
        }
        else
        {
            template().meshItem.hide();
        }
		
		showPopup();
	}
	
	override function onOK()
	{
		app.document.undoQueue.beginTransaction({ libraryChangeItems:[item.namePath] });
		
		if (Std.isOfType(item, MovieClipItem))
		{
			(cast item:MovieClipItem).likeButton = template().likeButton.prop("checked");
		}
		
		if (Std.isOfType(item, IFramedItem))
		{
			(cast item:IFramedItem).autoPlay = template().autoPlay.prop("checked");
			(cast item:IFramedItem).loop = template().loop.prop("checked");
		}
		
		if (Std.isOfType(item, ISpriteSheetableItem))
		{
			(cast item:ISpriteSheetableItem).exportAsSprite = template().exportAsSprite.prop("checked");
		}
		
		item.linkedClass = template().linkedClass.val();
		
		if (Std.is(item, MeshItem))
        {
            template().meshItem.show();
            (cast item:MeshItem).renderAreaSize = Std.parseInt(template().renderAreaSize.val(), MeshItem.DEFAULT_RENDER_AREA_SIZE);
            (cast item:MeshItem).loadLights = template().loadLights.prop("checked");
        }
        
        app.document.undoQueue.commitTransaction();
		
		app.document.library.update();
		
		app.document.editor.rebind();
	}
}