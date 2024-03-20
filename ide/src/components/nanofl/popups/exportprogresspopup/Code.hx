package components.nanofl.popups.exportprogresspopup;

using js.jquery.ui.Progressbar;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	override function init()
	{
		super.init();
		
        template().progressbar.progressbar({ value:false });
	}
	
	public function show(outputFile:String)
	{
		template().outputFile.val(outputFile); 

        showPopup();
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