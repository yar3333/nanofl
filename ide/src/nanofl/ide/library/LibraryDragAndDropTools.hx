package nanofl.ide.library;

import js.html.DragEvent;
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

    public static function dropIntoEditor(document:Document, view:View, type:DragDataType, params:DragInfoParams, data:String, e:JqEvent) : Void
    {
        final dropEffect = (cast e.originalEvent:DragEvent).dataTransfer.dropEffect;
        
        // don't get item here, because app.document.library.drop may reload items
        // so reference to item may became bad
        if (document.id != params.documentId)
        {
            LibraryDragAndDropTools.dropItemsIntoFolderInner(document, dropEffect, params, new XmlDocument(data), "").then(items ->
            {
                view.alerter.info("Items were added to library.");
                LibraryDragAndDropTools.addLibraryItemIntoEditor(document, view, document.library.getItem(params.libraryItemNamePath), e);
            });
        }
        else
        {
            LibraryDragAndDropTools.addLibraryItemIntoEditor(document, view, document.library.getItem(params.libraryItemNamePath), e);
        }
    }

	public static function dropToLibraryItemsFolder(document:Document, dropEffect:DropEffect, params:DragInfoParams, data:XmlDocument, folder:String)
	{
		Debug.assert(folder != null);
		
        LibraryDragAndDropTools.dropItemsIntoFolderInner(document, dropEffect, params, data, folder).then(droppedItems ->
		{
            document.library.update();
            
			if (droppedItems.length > 0)
			{
				document.library.select(droppedItems.map(x -> x.namePath));
			}
		});
	}    
	
	static function dropItemsIntoFolderInner(document:Document, dropEffect:DropEffect, params:DragInfoParams, data:HtmlNodeElement, folder:String) : Promise<Array<IIdeLibraryItem>>
	{
		Debug.assert(folder != null);
		
		log("LibraryItems.drop");
		
		if (document.id == params.documentId)
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

	public static function addLibraryItemIntoEditor(document:Document, view:View, item:IIdeLibraryItem, e:JqEvent)
	{
		log("addLibraryItemIntoEditor");
		
		if (document.navigator.pathItem.frame == null) { view.alerter.error("There is no frame to drop into."); return; }
		
		if (!Std.isOfType(item, InstancableItem)) { view.alerter.error("Items of the type '" + item.type + "' can't be added to the scene."); return; }

        final instance = (cast item:InstancableItem).newInstance();

		final obj = instance.createDisplayObject();
		final bounds = DisplayObjectTools.getInnerBounds(obj) ?? new Rectangle(0, 0, 0, 0);
		
		final pt = view.movie.editor.getMousePosOnDisplayObject(e);

        var dx = pt.x - bounds.x - bounds.width  / 2;
        var dy = pt.y - bounds.y - bounds.height / 2;

        if (document.editor.zoomLevel < 400)
        {
            dx = Math.round(dx);
            dy = Math.round(dy);
        }
        else
        {
            dx = Math.round(dx * 10) / 10;
            dy = Math.round(dy * 10) / 10;
        }
		
		instance.translate(dx, dy);

        final editorElement = document.editor.addElement(instance);
        document.editor.select(editorElement);
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
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.trace("", Reflect.isFunction(v) ? v() : v);
	}
}