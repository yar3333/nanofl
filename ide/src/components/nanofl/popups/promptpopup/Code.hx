package components.nanofl.popups.promptpopup;

class Code extends components.nanofl.popups.basepopup.Code
{
    var success : String->Void;
	
	public function show(title:String, label:String, ?text:String, success:String->Void)
	{
		template().title.html(title);
		template().label.html(label);
		template().text.val(text != null ? text : "");
		
		this.success = success;
		
		showPopup();
		
		template().text.select();
	}
	
	override function onOK()
	{
		success(template().text.val());
	}
}