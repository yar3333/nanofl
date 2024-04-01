package nanofl.ide.library.dropprocessors;

import nanofl.ide.draganddrop.DragInfoParams;
import js.html.DragEvent;
import nanofl.ide.draganddrop.DragDataType;
import nanofl.ide.draganddrop.IDropProcessor;
import js.JQuery;
import htmlparser.XmlDocument;
import easeljs.geom.Rectangle;
import nanofl.DisplayObjectTools;
import nanofl.engine.LayerType;
import nanofl.engine.elements.Element;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.Application;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.ui.View;

@:rtti
class LibraryItemToEditorDropProcessor extends InjectContainer
    implements IDropProcessor
{
	@inject var app : Application;
	@inject var view : View;
	
    public function getDragImageType(type:DragDataType, params:DragInfoParams) : DragImageType
	{
		if (type != DragDataType.LIBRARYITEMS) return null;
        if (params.width == null) return null;
		
        if (app.document.editor.activeLayer.type == LayerType.folder) return null;
        var k = app.document.editor.zoomLevel / 100;
		
		return DragImageType.RECTANGLE
		(
			Math.round(params.width  * k),
			Math.round(params.height * k)
		);
	}

    public function processDrop(type:DragDataType, params:DragInfoParams, data:String, e:JqEvent) : Bool
    {
        if (type != DragDataType.LIBRARYITEMS) return false;
        
        processDropInner((cast e.originalEvent:DragEvent).dataTransfer.dropEffect, new XmlDocument(data), e);
        return true;
    }
	
    function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent) : Void
	{
		log("editor.drop data");
		
		// don't get item here, because app.document.library.drop may reload items
		// so reference to item may became bad
		var namePath = data.getAttribute("namePath");
		
		if (app.document.id != data.getAttribute("documentID"))
		{
			app.document.library.dropItemsIntoFolder(dropEffect, data, "").then(items ->
			{
				view.alerter.info("Items were added to library.");
				processItem(app, view, app.document.library.getItem(namePath), e);
			});
		}
		else
		{
			processItem(app, view, app.document.library.getItem(namePath), e);
		}
	}
	
	public static function processItem(app:Application, view:View, item:IIdeLibraryItem, e:JqEvent)
	{
		log("editor.dropLibraryItem");
		
		if (app.document.navigator.pathItem.getTotalFrames() == 0) { view.alerter.error("There is no frame to drop into."); return; }
		
		if (Std.isOfType(item, InstancableItem))
		{
			addElementIntoEditor(app, view, (cast item:InstancableItem).newInstance(), e);
		}
		else
		{
			view.alerter.error("Items of the type '" + item.type + "' can't be added on the scene.");
		}
	}
	
	static function addElementIntoEditor(app:Application, view:View, element:Element, e:JqEvent)
	{
		var obj = element.createDisplayObject();
		var bounds = DisplayObjectTools.getInnerBounds(obj);
		
		if (bounds == null) bounds = new Rectangle(0, 0, 0, 0);
		
		var pt = view.movie.editor.getMousePosOnDisplayObject(e);
		
		element.translate(pt.x - bounds.x - bounds.width / 2, pt.y - bounds.y - bounds.height / 2);
		app.document.editor.addElement(element);
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
