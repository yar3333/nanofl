package nanofl.ide;

import js.lib.Promise;
import nanofl.ide.ui.Popups;
import stdlib.Uuid;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using StringTools;

@:rtti
abstract class OpenedFile extends InjectContainer
{
	@inject var openedFiles : OpenedFiles;
	@inject var popups : Popups;
	
	/**
	 * Document UUID (generated on every document object create).
	 */
	public var id(default, null) : String;
	
	public var isModified(get, never) : Bool;
	abstract function get_isModified() : Bool;
	
	public abstract function getPath() : String;
	public abstract function getLongTitle() : String;
	public abstract function getShortTitle() : String;
	public abstract function getIcon() : String;
	public abstract function getTabTextColor() : String;
	public abstract function getTabBackgroundColor() : String;
	
	public abstract function activate(?isCenterView:Bool) : Void;
	public abstract function deactivate() : Void;
	
	public var relatedDocument : Document;
	
	function new(relatedDocument:Document)
	{
		super();
		
		this.id = Uuid.newUuid();
		this.relatedDocument = relatedDocument;
	}
	
	public var type(get, never) : OpenedFileType;
	abstract function get_type() : OpenedFileType;
	
	public function saveWithPrompt() : Promise<Bool>
	{
		if (isModified)
		{
			return new Promise<Bool>(function(resolve, reject)
			{
                popups.showConfirm("Confirmation", "Document was changed!", "Save", "Cancel", "Don't save").then(r ->
                {
                    switch (r.response)
                    {
                        case 0: save().then(r -> resolve(r));
                        case 1: // do nothing
                        case 2: resolve(true);
                        case _: reject(new js.lib.Error());
                    }
                });
			});
		}
		else
		{
			return Promise.resolve(true);
		}
	}
	
 	public function close(?force:Bool) : Promise<{}>
 	{
		if (force)
		{
			dispose();
			openedFiles.close(this);
			return Promise.resolve(null);
		}
		else
		{
			return saveWithPrompt().then(function(success:Bool)
			{
				dispose();
				openedFiles.close(this);
				return null;
			});
		}
 	}	
	
	public function undoStatusChanged() : Void
	{
		openedFiles.titleChanged(this);
	}
	
	public abstract function save() : Promise<Bool>;
	
	public abstract function undo() : Void;
	public abstract function redo() : Void;
	
	public abstract function dispose() : Void;
	
	public abstract function toggleSelection() : Void;
	public abstract function deselectAll() : Void;
	
	public abstract function canBeSaved() : Bool;
	
	public abstract function canUndo() : Bool;
	public abstract function canRedo() : Bool;
	
	public abstract function canCut() : Bool;
	public abstract function canCopy() : Bool;
	public abstract function canPaste() : Bool;
}