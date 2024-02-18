package nanofl.ide.library.droppers;

import easeljs.geom.Rectangle;
import htmlparser.HtmlNodeElement;
import js.JQuery.JqEvent;
import nanofl.DisplayObjectTools;
import nanofl.engine.LayerType;
import nanofl.engine.elements.Element;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.Application;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDropArea;
import nanofl.ide.ui.View;
using nanofl.engine.LayersTools;

@:rtti
class LibraryItemToEditorDropper
	extends InjectContainer
	implements IDropArea
{
	@inject var app : Application;
	@inject var view : View;
	
	public function getDragImageType(data:HtmlNodeElement) : DragImageType
	{
		if (data.getAttribute("width") == null) return null;
		
        if (app.document.editor.activeLayer.type == LayerType.folder) return null;
        var k = app.document.editor.zoomLevel / 100;
		
		return DragImageType.RECTANGLE
		(
			Math.round(Std.parseFloat(data.getAttribute("width" )) * k),
			Math.round(Std.parseFloat(data.getAttribute("height")) * k)
		);
	}
	
	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent)
	{
		log("editor.drop data");
		
		// don't get item here, because app.document.library.drop may reload items
		// so reference to item may became bad
		var namePath = data.getAttribute("namePath");
		
		if (app.document.id != data.getAttribute("documentID"))
		{
			app.document.library.drop(dropEffect, data, "").then(function(items:Array<IIdeLibraryItem>)
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
		
		if (app.document.navigator.pathItem.element.getTotalFrames() == 0) { view.alerter.error("There is no frame to drop into."); return; }
		
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
		var obj = element.createDisplayObject(null);
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
