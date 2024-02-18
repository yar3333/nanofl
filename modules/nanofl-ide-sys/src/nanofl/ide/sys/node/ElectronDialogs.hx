package nanofl.ide.sys.node;

import js.lib.Promise;
import nanofl.ide.sys.Dialogs;
import nanofl.ide.sys.node.core.ElectronApi;

class ElectronDialogs implements Dialogs
{
	public function new() {}

    public function showOpenDialog(options:ShowOpenDialogOptions) : Promise<ShowOpenDialogResult>
    {
        return ElectronApi.callMethodAsync("dialog", "showOpenDialog", null, options);
    }

    public function showSaveDialog(options:ShowSaveDialogOptions) : Promise<ShowSaveDialogResult>
    {
        return ElectronApi.callMethodAsync("dialog", "showSaveDialog", null, options);
    }
    
    public function showMessageBox(options:ShowMessageBoxOptions) : Promise<ShowMessageBoxResult>
    {
        return ElectronApi.callMethodAsync("dialog", "showMessageBox", null, options);
    }
}
