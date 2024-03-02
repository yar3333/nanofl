package nanofl.ide;

import htmlparser.XmlBuilder;
import htmlparser.XmlDocument;
import js.Browser;
import js.JQuery;
import nanofl.ide.libraryitems.BitmapItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.editor.Editor;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.keyboard.Keys;
import nanofl.ide.keyboard.Shortcut;
import nanofl.ide.library.LibraryItems;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.timeline.IIdeTimeline;
import nanofl.ide.ui.View;
using StringTools;
using stdlib.Lambda;

@:rtti
class Clipboard extends InjectContainer
{
	@inject var fileSystem : FileSystem;
	@inject var preferences : Preferences;
	@inject var folders : Folders;
	@inject var keyboard : Keyboard;
	@inject var app : Application;
	@inject var clipboard : nanofl.ide.sys.Clipboard;
	
	var view : View;
	
	public function setView(view:View) : Void
	{
		this.view = view;
	}

	public function new()
	{
		super();
		
		new JQuery(Browser.document).keydown(function(e)
		{
			if (!isInputActive())
			{
				if (Shortcut.ctrl(Keys.X).test(e)) { e.preventDefault(); cut(); }
				if (Shortcut.ctrl(Keys.C).test(e)) { e.preventDefault(); copy(); }
				if (Shortcut.ctrl(Keys.V).test(e)) { e.preventDefault(); paste(); }
			}
		});
	}
	
	function copyInner(isCut:Bool) : Bool
	{
		var data = getStringForCopy(isCut);
		if (data != null)
		{
			clipboard.writeText(data);
			return true;
		}
		return false;
	}
	
	public function canCut() : Bool
	{
		return canCopy();
	}
	
	public function canCopy() : Bool
	{
		if (isInputActive())
		{
			var input : js.html.InputElement = cast js.Browser.document.activeElement;
			return input.selectionStart != null && input.selectionStart != input.selectionEnd;
		}
		else
		{
			switch (app.activeView)
			{
				case ActiveView.LIBRARY:
					return app.document.library.hasSelected();
					
				case ActiveView.EDITOR:
                    return app.document.editor.hasSelected();
					
				case ActiveView.TIMELINE:	
                    return view.movie.timeline.hasSelectedFrames();
					
				case ActiveView.OUTPUT:
					return view.output.hasSelected();
			}
		}
	}
	
	public function canPaste() : Bool
	{
		return hasText() || hasImage();
	}
	
	public function cut() : Bool
	{
		log("cut");
		return copyInner(true);
	}
	
	public function copy() : Bool
	{
		log("copy");
		return copyInner(false);
	}
	
	public function paste() : Bool
	{
        log("paste");
		
		if (hasText())
		{
			log("paste text");
			return pasteString(getStringFromClipboard());
		}
		else
		if (hasImage())
		{
            var namePath = app.document.library.getNextItemName();
            var destFile = app.document.library.libraryDir + "/" + namePath + ".png";
            log("paste image: " + destFile);
            var r = savePngImageFromClipboard(destFile);
            if (r)
            {
                app.document.undoQueue.beginTransaction({ libraryAddItems:true });
                
                var item = new BitmapItem(namePath, "png");
                app.document.library.addItems([ item ], false);
                app.document.library.preload().then(function(_)
                {
                    app.document.library.update();
                    app.document.library.activeItem = item;
                    
                    if (app.activeView == ActiveView.EDITOR || app.activeView == ActiveView.TIMELINE)
                    {
                        app.document.undoQueue.beginTransaction({ elements:true });
                        app.document.editor.addElement(item.newInstance(), false);
                    }
                    
                    app.document.undoQueue.commitTransaction();
                });
            }
            return r;
		}
		
		log("paste NOTHING");
		return false;
	}
	
	function pasteString(data:String) : Bool
	{
		if (isInputActive())
		{
			log("pasteString isInputActive = true");
			
			var activeElement : js.html.InputElement = cast Browser.document.activeElement;
			if (activeElement.selectionStart != null)
			{
				activeElement.value = activeElement.value.substring(0, activeElement.selectionStart)
									+ data
									+ activeElement.value.substring(activeElement.selectionEnd);
				return true;
			}
			return false;
		}
		else
		{
			log("pasteString isInputActive = false");
			
			switch (app.activeView)
			{
				case ActiveView.EDITOR, ActiveView.LIBRARY, ActiveView.TIMELINE, ActiveView.OUTPUT:
					var xml = try new XmlDocument(data) catch (_:Dynamic) return false;
					if (xml.nodes.length == 0) return false;
					
					app.document.undoQueue.beginTransaction
					({
						figure: true,
						elements: true,
						timeline: true,
						libraryAddItems: true
					});
					
					final success = app.document.library.loadFilesFromClipboard();
                    log("loadFilesFromClipboard " + success);
                    if (success)
                    {
                        app.document.reloadWoTransactionForced().then(_ ->
                        {
                            pasteStringInner(xml);
                        });
                    }
                    else
                    {
                        pasteStringInner(xml);
                    }
			}
			
			return true;
		}
	}
	
	function pasteStringInner(xml:XmlDocument)
	{
		var invalidater = new Invalidater();
		
		var items = LibraryItems.loadFromXml(xml);
		
		if (items.length > 0)
		{
			app.document.library.addItems(items, false);
			invalidater.invalidateLibrary();
			app.document.library.preload().then(function(_)
			{
				pasteStringInner2(xml, invalidater, app.document.editor, view.movie.timeline);
			});
		}
		else
		{
			pasteStringInner2(xml, invalidater, app.document.editor, view.movie.timeline);
		}
	}
	
	function pasteStringInner2(xml:XmlDocument, invalidater:Invalidater, editor:Editor, timeline:IIdeTimeline)
	{
		if (timeline.pasteFromXml(xml))
		{
			invalidater.invalidateTimelineFrames();
			invalidater.invalidateEditorDeep();
		}
		
		if (editor.pasteFromXml(xml))
		{
			invalidater.invalidateEditorLight();
		}
		invalidater.updateInvalidated(editor, timeline, view.library);
		
		app.document.undoQueue.commitTransaction();
	}
	
	public function restoreFocus(?e:js.html.MouseEvent)
	{
		if (e != null && js.Browser.document.activeElement != e.target && isInputActive())
		{
			js.Browser.document.activeElement.blur();
		}
	}
	
	function getStringForCopy(isCut:Bool) : String
	{
		if (isInputActive())
		{
			log("getStringForCopy isInputActive = true");
			
			var input : js.html.InputElement = cast js.Browser.document.activeElement;
			if (input.selectionStart != null && input.selectionStart != input.selectionEnd)
			{
				var r = input.value.substring(input.selectionStart, input.selectionEnd);
				if (isCut)
				{
					input.value = input.value.substring(0, input.selectionStart) + input.value.substring(input.selectionEnd);
				}
				return r;
			}
			return null;
		}
		else
		{
			log("getStringForCopy isInputActive = false");
			
			if (app.activeView == null) return null;
			
			switch (app.activeView)
			{
				case ActiveView.EDITOR:
					var out = new XmlBuilder();
					
					var items : Array<IIdeLibraryItem>;
                    items = app.document.editor.saveSelectedToXml(out);
                    if (isCut) app.document.editor.removeSelected();
							
					return getStringForCopyFromLibraryItems(out, items);
					
				case ActiveView.LIBRARY:
					var out = new XmlBuilder();
					var items = app.document.library.getSelectedItemsWithDependencies();
					if (isCut) app.document.library.removeSelected();
					return getStringForCopyFromLibraryItems(out, items);
					
				case ActiveView.TIMELINE:
					var out = new XmlBuilder();
					var items = view.movie.timeline.saveSelectedToXml(out);
					if (isCut) view.movie.timeline.removeSelectedFrames();
					return getStringForCopyFromLibraryItems(out, items);
					
				case ActiveView.OUTPUT:
					return view.output.getSelectedText();
			}
		}
	}
	
	function getStringForCopyFromLibraryItems(out:XmlBuilder, items:Array<IIdeLibraryItem>) : String
	{
		LibraryItems.saveToXml(items, out);
		
		var data = out.toString();
		
		log("copy items = " + items.length);
		var files = LibraryItems.getFiles(items);
		log("copy files = " + files.length);
		saveFilesIntoClipboard(app.document.library.libraryDir, files);
		
		return data;
	}
	
	function isInputActive() : Bool
	{
		var activeElement = Browser.document.activeElement;
		return activeElement != null && ["textarea", "input", "select"].indexOf(activeElement.nodeName.toLowerCase()) >= 0;
	}
	
	function hasText() return clipboard.hasText();
	function hasImage() return clipboard.hasImage();
	
	function getStringFromClipboard() : String
	{
		return clipboard.readText();
	}
	
	function savePngImageFromClipboard(destPath:String) : Bool
	{
		var data = clipboard.readImageAsPngBytes();
		fileSystem.saveBinary(destPath, data);
        return true;
	}
	
	public function loadFilesFromClipboard(destDir:String) : Void
	{
		var clipboardDir = folders.temp + "/clipboard";
        if (fileSystem.exists(clipboardDir))
        {
            fileSystem.copyAny(clipboardDir, destDir);
        }
	}
	
	public function saveFilesIntoClipboard(baseDir:String, relativePaths:Array<String>) : Void
	{
		var clipboardDir = folders.temp + "/clipboard";
		
		fileSystem.deleteAny(clipboardDir + "/*");
		
		for (relativePath in relativePaths)
		{
			fileSystem.copyAny(baseDir + "/" + relativePath, clipboardDir + "/" + relativePath);
		}
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}