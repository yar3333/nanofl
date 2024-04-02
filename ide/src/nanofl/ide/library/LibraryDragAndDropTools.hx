package nanofl.ide.library;

import nanofl.engine.elements.Element;
import easeljs.geom.Rectangle;
import js.JQuery.JqEvent;
import nanofl.engine.LayerType;
import nanofl.ide.draganddrop.DragDataType;
import nanofl.ide.draganddrop.DragImageType;
import htmlparser.XmlDocument;
import nanofl.ide.ui.View;
import stdlib.Debug;
import htmlparser.HtmlNodeElement;
import nanofl.ide.draganddrop.DropEffect;
import htmlparser.XmlBuilder;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.draganddrop.DragInfoParams;
import haxe.io.Path;
import js.lib.Promise;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.FolderItem;

class LibraryDragAndDropTools
{
	public static function getDragParams(document:Document, item:IIdeLibraryItem, items:Array<IIdeLibraryItem>) : DragInfoParams
	{
        final r : DragInfoParams =
        {
            documentId: document.id,
            
            icon: item.getIcon(),
            text: item.namePath,

            libraryItemNamePath: item.namePath,
        };

		if (Std.isOfType(item, InstancableItem))
		{
			final obj = (cast item:InstancableItem).createDisplayObject(null);
			final bounds =  DisplayObjectTools.getInnerBounds(obj);
			r.width = bounds?.width ?? 0;
			r.height = bounds?.height ?? 0;
		}

        return r;
	}
		
    public static function getDragData(document:Document, item:IIdeLibraryItem, items:Array<IIdeLibraryItem>) : String
    {
        final out = new XmlBuilder();

        LibraryItems.saveToXml(items, out);
		
		final files = LibraryItems.getFiles(items);
		if (files.length > 0)
		{
			out.begin("libraryfiles").attr("libraryDir", document.library.libraryDir);
			for (file in files)
			{
				out.begin("file").attr("path", file).end();
			}
			out.end();
		}
		
		return out.toString();
	}

	public static function getDragImageTypeIconText(view:View, type:DragDataType, params:DragInfoParams) : DragImageType
	{
		if (type != DragDataType.LIBRARYITEMS || view.library.readOnly) return null;

		return DragImageType.ICON_TEXT(params.icon, params.text); // or namePath
	}

    public static function getDragImageTypeRectangle(document:Document, type:DragDataType, params:DragInfoParams) : DragImageType
	{
		if (type != DragDataType.LIBRARYITEMS) return null;
        if (params.width == null) return null;
		
        if (document.editor.activeLayer.type == LayerType.folder) return null;
        var k = document.editor.zoomLevel / 100;
		
		return DragImageType.RECTANGLE
		(
			Math.round(params.width  * k),
			Math.round(params.height * k)
		);
	}    

	public static function dropToLibraryItemsFolder(document:Document, view:View, dropEffect:DropEffect, data:XmlDocument, folder:String)
	{
		Debug.assert(folder != null);
		
		final saveActiveItem = view.library.activeItem;
		view.library.activeItem = null;

        LibraryDragAndDropTools.dropItemsIntoFolderInner(dropEffect, data, document, folder).then(droppedItems ->
		{
			if (droppedItems.length > 0)
			{
				view.library.select(droppedItems.map(x -> x.namePath));
				view.library.activeItem = droppedItems[0];
			}
			else
			{
				view.library.activeItem = saveActiveItem;
			}
			view.library.update();
		});
	}    
	
	public static function dropItemsIntoFolderInner(dropEffect:DropEffect, data:HtmlNodeElement, document:Document, folder:String) : Promise<Array<IIdeLibraryItem>>
	{
		Debug.assert(folder != null);
		
		var sourceDocumentID = data.getAttribute("documentID");
		
		log("LibraryItems.drop");
		
		if (document.id == sourceDocumentID)
		{
			log("\tjust rename");
			
			if (folder != "") (cast document.library.getItem(folder) : FolderItem).opened = true;
			
			final namePaths = data.find(">libraryitems>item")
				.map(x -> x.getAttribute("namePath"))
				.filter(namePath ->
				{
					if (!document.library.hasItem(namePath))
					{
						log("IdeLibrary item not found: '" + namePath + "'.");
						return false;
					}
					return true;
				});
			
			final renames = [];
			for (namePath in getWithoutSubItems(namePaths))
			{
				final newNamePath = Path.join([ folder, Path.withoutDirectory(namePath) ]);
				if (namePath != newNamePath && document.library.canRenameItem(namePath, newNamePath))
				{
					renames.push({ oldNamePath:namePath, newNamePath:newNamePath });
				}
			}
			document.library.renameItems(renames);
			
			return Promise.resolve(renames.map(x -> document.library.getItem(x.newNamePath)));
		}
		else
		{
			final items = LibraryItems.loadFromXml(data);
			log("\titems: " + items.map(x -> x.namePath));
			
			document.undoQueue.beginTransaction({ libraryAddItems:true });
			
			document.library.addItems(items, false);
			
			final libraryFilesNodes = data.find(">libraryfiles");
			if (libraryFilesNodes.length > 0)
			{
				final libraryDir = libraryFilesNodes[0].getAttribute("libraryDir");
				final files = libraryFilesNodes[0].find(">file").map(x -> x.getAttribute("path"));
				document.library.copyFilesIntoLibrary(libraryDir, files);
                log("\tfiles copied into library");
                
                return document.reloadWoTransactionForced().then((e:{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }) ->
                {
                    log("\tdocument reloaded\n\t" + e.added.map(x -> x.namePath).join("\n\t"));
                    document.undoQueue.commitTransaction();
                    return items.concat(e.added);
                });
			}
			else
			{
				log("\tno files");
				document.undoQueue.commitTransaction();
				return Promise.resolve(items);
			}
		}
	}
	
	static function getWithoutSubItems(namePaths:Array<String>) : Array<String>
	{
		final r = [];
		
		for (namePath in namePaths)
		{
			var skip = false;
			
			var folder = namePath;
			while (folder.indexOf("/") > 0)
			{
				folder = Path.directory(folder);
				if (namePaths.indexOf(folder) >= 0)
				{
					skip = true;
					break;
				}
			}
			
			if (!skip) r.push(namePath);
		}
		
		return r;
	}

	public static function addLibraryItemIntoEditor(app:Application, view:View, item:IIdeLibraryItem, e:JqEvent)
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

	public static function getTargetFolderForDrop(document:Document, namePath:String) : String
	{
		var folder = namePath;
		if (folder == null) folder = "";
		if (folder != "" && !Std.isOfType(document.library.getItem(folder), FolderItem))
		{
			folder = Path.directory(folder);
		}
		return folder;
	}
	
    static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}