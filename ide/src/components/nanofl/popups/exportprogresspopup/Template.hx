package components.nanofl.popups.exportprogresspopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var outputFile(get, never) : js.JQuery;
	inline function get_outputFile() return component.q('#outputFile');
    
    public var progressbar(get, never) : js.JQuery;
	inline function get_progressbar() return component.q('#progressbar');

    public var info(get, never) : js.JQuery;
	inline function get_info() return component.q('#info');
}