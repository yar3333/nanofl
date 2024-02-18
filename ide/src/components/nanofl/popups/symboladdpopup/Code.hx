package components.nanofl.popups.symboladdpopup;

class Code extends components.nanofl.popups.basepopup.Code
{
    var success : { name:String, regX:Int, regY:Int }->Void;
	
	override function init()
    {
		super.init();
		
		var regPoints = template().registration.find(">*");
		regPoints.click(function(e)
		{
			regPoints.removeClass("active");
			q(e.target).addClass("active");
		});
    }
	
	public function show(title:String, name:String, success:{ name:String, regX:Int, regY:Int }->Void)
	{
		template().title.html(title);
		template().name.val(name);
		
		this.success = success;
		
		showPopup();
	}
	
	override function onOK()
	{
		var activeRegIndex = template().registration.find(">.active").index();
		var regX = activeRegIndex % 3 - 1;
		var regY = Std.int(activeRegIndex / 3) - 1;
		
		success({ name:template().name.val(), regX:regX, regY:regY });
	}
}