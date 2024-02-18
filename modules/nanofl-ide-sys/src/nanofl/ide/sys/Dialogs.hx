package nanofl.ide.sys;

import js.lib.Promise;

@:rtti
interface Dialogs
{
    function showOpenDialog(options:ShowOpenDialogOptions) : Promise<ShowOpenDialogResult>;
    function showSaveDialog(options:ShowSaveDialogOptions) : Promise<ShowSaveDialogResult>;
    function showMessageBox(options:ShowMessageBoxOptions) : Promise<ShowMessageBoxResult>;
}

typedef FileFilter =
{
	var name : String;
	var extensions : Array<String>;
}

typedef ShowOpenDialogOptions = 
{ 
    @:optional
	var title : String;
    
    @:optional
	var defaultPath : String; 
    
    /**
		Custom label for the confirmation button, when left empty the default label will be used.
	**/
	@:optional
	var buttonLabel : String;
    
    @:optional
	var filters : Array<FileFilter>;
    
    /**
		Contains which features the dialog should use. The following values are supported:
	**/
	@:optional
	var properties : Array<String>;
    
    /**
		Message to display above input boxes.
	**/
	@:optional
	var message : String; 
    
    /**
		Create security scoped bookmarks when packaged for the Mac App Store.
	**/
	@:optional
	var securityScopedBookmarks : Bool; 
};

typedef ShowOpenDialogResult =
{ 
    /**
		whether or not the dialog was canceled.
	**/
	var canceled : Bool; 
    
    /**
		An array of file paths chosen by the user. If the dialog is cancelled this will be an empty array.
	**/
	var filePaths : Array<String>; 
    
    /**
		An array matching the `filePaths` array of base64 encoded strings which contains security scoped bookmark data. `securityScopedBookmarks` must be enabled for this to be populated. (For return values, see table here.)
	**/
	@:optional
	var bookmarks : Array<String>; 
};

typedef ShowSaveDialogOptions =
{ 
    /**
        The dialog title. Cannot be displayed on some _Linux_ desktop environments.
    **/
    @:optional
    var title : String; 
    
    /**
        Absolute directory path, absolute file path, or file name to use by default.
    **/
    @:optional
    var defaultPath : String; 
    
    /**
        Custom label for the confirmation button, when left empty the default label will be used.
    **/
    @:optional
    var buttonLabel : String; 
    
    @:optional
    var filters : Array<FileFilter>; 
    
    /**
        Message to display above text fields.
    **/
    @:optional
    var message : String; 
    
    /**
        Custom label for the text displayed in front of the filename text field.
    **/
    @:optional
    var nameFieldLabel : String; 
    
    /**
        Show the tags input box, defaults to `true`.
    **/
    @:optional
    var showsTagField : Bool; @:optional
    var properties : Array<String>; 
    
    /**
        Create a security scoped bookmark when packaged for the Mac App Store. If this option is enabled and the file doesn't already exist a blank file will be created at the chosen path.
    **/
    @:optional
    var securityScopedBookmarks : Bool;
};

typedef ShowSaveDialogResult =
{ 
    /**
        whether or not the dialog was canceled.
    **/
    var canceled : Bool; 
    
    /**
        If the dialog is canceled, this will be `undefined`.
    **/
    @:optional
    var filePath : String; 
    
    /**
        Base64 encoded string which contains the security scoped bookmark data for the saved file. `securityScopedBookmarks` must be enabled for this to be present. (For return values, see table here.)
    **/
    @:optional
    var bookmark : String; 
};

typedef ShowMessageBoxOptions =
{ 
    /**
    Content of the message box.
    **/
    var message : String; 
    
    /**
        Can be `none`, `info`, `error`, `question` or `warning`. On Windows, `question` displays the same icon as `info`, unless you set an icon using the `icon` option. On macOS, both `warning` and `error` display the same warning icon.
    **/
    @:optional
    var type : String; 
    
    /**
        Array of texts for buttons. On Windows, an empty array will result in one button labeled "OK".
    **/
    @:optional
    var buttons : Array<String>; 
    
    /**
        Index of the button in the buttons array which will be selected by default when the message box opens.
    **/
    @:optional
    var defaultId : Int; 
    
    /**
        Pass an instance of AbortSignal to optionally close the message box, the message box will behave as if it was cancelled by the user. On macOS, `signal` does not work with message boxes that do not have a parent window, since those message boxes run synchronously due to platform limitations.
    **/
    @:optional
    var signal : Dynamic; 
    
    /**
        Title of the message box, some platforms will not show it.
    **/
    @:optional
    var title : String; 
    
    /**
        Extra information of the message.
    **/
    @:optional
    var detail : String; 
    
    /**
        If provided, the message box will include a checkbox with the given label.
    **/
    @:optional
    var checkboxLabel : String; 
    
    /**
        Initial checked state of the checkbox. `false` by default.
    **/
    @:optional
    var checkboxChecked : Bool; 
    
    @:optional
    //var icon : haxe.extern.EitherType<electron.NativeImage, String>; 
    var icon : haxe.extern.EitherType<Dynamic, String>; 
    
    /**
        Custom width of the text in the message box.
    **/
    @:optional
    var textWidth : Int; 
    
    /**
        The index of the button to be used to cancel the dialog, via the `Esc` key. By default this is assigned to the first button with "cancel" or "no" as the label. If no such labeled buttons exist and this option is not set, `0` will be used as the return value.
    **/
    @:optional
    var cancelId : Int; 
    
    /**
        On Windows Electron will try to figure out which one of the `buttons` are common buttons (like "Cancel" or "Yes"), and show the others as command links in the dialog. This can make the dialog appear in the style of modern Windows apps. If you don't like this behavior, you can set `noLink` to `true`.
    **/
    @:optional
    var noLink : Bool; 
    
    /**
        Normalize the keyboard access keys across platforms. Default is `false`. Enabling this assumes `&` is used in the button labels for the placement of the keyboard shortcut access key and labels will be converted so they work correctly on each platform, `&` characters are removed on macOS, converted to `_` on Linux, and left untouched on Windows. For example, a button label of `Vie&w` will be converted to `Vie_w` on Linux and `View` on macOS and can be selected via `Alt-W` on Windows and Linux.
    **/
    @:optional
    var normalizeAccessKeys : Bool; 
};

typedef ShowMessageBoxResult =
{ 
    /**
        The index of the clicked button.
    **/
    var response : Float; 
    
    /**
        The checked state of the checkbox if `checkboxLabel` was set. Otherwise `false`.
    **/
    var checkboxChecked : Bool; 
};
