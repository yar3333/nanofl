import js.Browser;
import js.html.CanvasElement;
import easeljs.display.Shape;
import easeljs.display.Stage;
//import createjs.GaussianBlurFilter;
//import easeljs.filters.BlurFilter;
import createjs.DropShadowFilter;

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
		
		//obj.filters = [ new GaussianBlurFilter(30) ];
		//obj.filters = [ new BlurFilter(30, 30) ];
		obj.filters = [ new DropShadowFilter(30, 45, 0x00FF00, 0.5) ];
		
		obj.cache(30, 30, 100, 100);
		
		stage.update();
	}
}
