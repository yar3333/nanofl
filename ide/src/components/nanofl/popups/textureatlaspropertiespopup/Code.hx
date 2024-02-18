package components.nanofl.popups.textureatlaspropertiespopup;

import nanofl.ide.DocumentProperties;
import nanofl.ide.textureatlas.TextureAtlasParams;
import stdlib.Std;

class Code extends components.nanofl.popups.basepopup.Code
{
	var success : { name:String, params:TextureAtlasParams }->Void;
	
	public function show(name:String, params:TextureAtlasParams, success:{ name:String, params:TextureAtlasParams }->Void)
	{
		if (params == null) params = new TextureAtlasParams();
		
		template().name.val(name);
		template().width.val(params.width);
		template().height.val(params.height);
		template().padding.val(params.padding);
		
		this.success = success;
		
		showPopup();
	}
	
	override function onOK()
	{
		var name = template().name.val();
		
		if (name != "")
		{
			success
			({
				name: name,
				params: new TextureAtlasParams
				(
					Std.parseInt(template().width.val(), 2048),
					Std.parseInt(template().height.val(), 2048),
					Std.parseInt(template().padding.val(), 0)
				)
			});
		}
	}
}