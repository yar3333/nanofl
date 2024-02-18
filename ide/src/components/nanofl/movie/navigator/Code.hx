package components.nanofl.movie.navigator;

import haxe.io.Path;
import nanofl.engine.Library;
import nanofl.ide.Application;
import nanofl.ide.Globals;
import nanofl.ide.navigator.PathItem;
import js.JQuery;

@:rtti
class Code extends wquery.Component
{
	@inject var app : Application;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		template().container.off("click", ">li>a");
		
		template().container.on("click", ">li>a", function(e:JqEvent)
		{
			var index : Int = q(e.currentTarget).data("index");
			
            var editPath = app.document.navigator.editPath.slice(0, index + 1);
            if (editPath.length == 0)
            {
                editPath.push(new PathItem(app.document.library.getSceneInstance()));
            }
            app.document.navigator.navigateTo(editPath);
		});
	}
	
	public function update()
	{
		var s = "";
		
		var editPath = app.document.navigator.editPath;
		if (!editPath[0].isScene())
		{
			s += getLi(-1, Library.SCENE_NAME_PATH, app.document.library.getSceneItem().getIcon(), false);
		}
		for (i in 0...editPath.length)
		{
			s += getLi(i, editPath[i].getNavigatorName(), editPath[i].getNavigatorIcon(), i == editPath.length - 1);
		}
		
		template().container.html(s);
	}
	
	function getLi(index:Int, name:String, icon:String, isLast:Bool)
	{
		return "<li" + (isLast ? " class='active'" : "") + " title='" + name + "'>"
			 + (!isLast ? "<a href='javascript:void(0)' data-index='" + index +"'>" : "")
			 + "<i class='" + icon + "'></i>"
			 + " " + Path.withoutDirectory(name)
			 + (!isLast ? "</a>" : "")
			 + (!isLast ? "<span class='divider'>/</span>" : "")
			 + "</li>";
	}
	
	public function height()
	{
		return template().container.outerHeight();
	}
}