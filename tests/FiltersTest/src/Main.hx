import createjs.GaussianBlurFilter;
import createjs.Shape;
import createjs.Stage;
import js.Browser;
import js.html.CanvasElement;

class Main
{
	static public function main()
	{
		var canvas : CanvasElement = cast Browser.document.getElementById("canvas");
		
		var stage = new Stage(canvas);
		
		var obj = new Shape(); stage.addChild(obj);
		obj.graphics
			.beginFill("red")
			.rect(30, 30, 100, 100)
			.endFill();
		obj.setBounds(30, 30, 100, 100);
		
		obj.filters = [ new GaussianBlurFilter(30, 30) ];
		
		obj.cache(30, 30, 100, 100);
		
		stage.update();
	}
}
