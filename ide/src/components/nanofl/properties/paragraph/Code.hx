package components.nanofl.properties.paragraph;

import js.JQuery;
import nanofl.ide.PropertiesObject;
import nanofl.TextRun;

class Code extends components.nanofl.properties.base.Code
{
	override function init()
	{
		super.init();
		
		template().align.on("click", ">*", e -> { new JQuery(e.currentTarget).addClass("active").siblings().removeClass("active"); changeAlign(); });
	}
	
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.TEXT(item, newObjectParams):
				show();
				
				var format = item != null ? item.getSelectionFormat() : newObjectParams.textFormat;
				
				template().align.children().removeClass("active");
				template().align.find(">[data-value=" + format.align + "]").addClass("active");
				
				template().lineSpacing.val(format.lineSpacing);
				
			case _:
				hide();
		};
	}
	
	function changeAlign()
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.TEXT(item, newObjectParams):
				var align = template().align.find(">.active").data("value");
				newObjectParams.textFormat.align = align;
				if (item != null)
				{
					undoQueue.beginTransaction({ element:item.originalElement });
					
					var t = Type.createEmptyInstance(TextRun);
					t.align = align;
					item.setSelectionFormat(t);
					
					undoQueue.commitTransaction();
					
					fireChangeEvent();
				}
				
			case _:
		}
	}
	
	function lineSpacing_change(_)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.TEXT(item, newObjectParams):
				var lineSpacing = Std.parseFloat(template().lineSpacing.val());
				if (!Math.isNaN(lineSpacing))
				{
					newObjectParams.textFormat.lineSpacing = lineSpacing;
					if (item != null)
					{
						undoQueue.beginTransaction({ element:item.originalElement });
						
						var t = Type.createEmptyInstance(TextRun);
						t.lineSpacing = lineSpacing;
						item.setSelectionFormat(t);
						
						undoQueue.commitTransaction();
						
						fireChangeEvent();
					}
				}
				
			case _:
		}
	}
}