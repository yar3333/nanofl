package components.nanofl.popups.custompropertiespopup;

import nanofl.engine.CustomProperty;

class Code extends components.nanofl.popups.basepopup.Code
{
	static var imports =
	{
		"custom-properties-table-form": components.nanofl.others.custompropertiestableform.Code
	};
	
	var originalParams : Dynamic;
	var currentParams : Dynamic;
	
	public function show(title:String, properties:Array<CustomProperty>, params:Dynamic)
	{
		template().title.html(title);
		
		originalParams = params;
		currentParams = Reflect.copy(params);
		template().customProperties.bind(properties, currentParams);
		
		showPopup();
	}
	
	override function onOK()
	{
		for (name in Reflect.fields(currentParams))
		{
			Reflect.setField(originalParams, name, Reflect.field(currentParams, name));
		}
	}
}