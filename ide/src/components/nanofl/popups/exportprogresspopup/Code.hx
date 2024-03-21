package components.nanofl.popups.exportprogresspopup;

using js.jquery.ui.Progressbar;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
    var cancelFunc : ()->Void;

	override function init()
	{
		super.init();
		
        template().progressbar.progressbar({ value:false });
	}
	
	public function show(outputFile:String, cancelFunc:()->Void)
	{
		template().outputFile.val(outputFile); 
        this.cancelFunc = cancelFunc;

        showPopup();
	}

    override function onCancel()
    {
        if (cancelFunc != null) cancelFunc();
    }

    public function close()
    {
        hide();
    }

    public function setPercent(percent:Int)
    {
        template().progressbar.progressbarValueSet(percent);
    }

    public function setInfo(text:String)
    {
        template().info.html(text);
    }
}