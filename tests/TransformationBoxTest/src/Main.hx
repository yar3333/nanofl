import createjs.Shape;
import createjs.Stage;
import createjs.Matrix2D;
import nanofl.TransformationBox;
import js.Browser;
import js.JQuery;

class Main
{
	static public function main()
	{
		new JQuery(cast Browser.document).ready(function(e)
		{
			var stage = new Stage(Browser.document.querySelector("#canva"));
			
			var tb = new TransformationBox();
			stage.addChild(tb);
			tb.x = 200;
			tb.y = 100;
			tb.width = 100;
			tb.height = 50;
			tb.regPointX = 10;
			tb.regPointY = 20;
			
			tb.minWidth = 50;
			tb.minHeight = 20;
			
			//tb.skewX = 20; tb.rotation = 10;
			//tb.skewX = 28.88; tb.skewY = 10;
			
			/*var m = tb.getMatrix();
			var t = m.decompose();
			trace(t);*/
			
			/*var shape = new Shape(); stage.addChild(shape);
			shape.graphics.beginStroke("red");
			shape.graphics.rect(0, 0, 100, 50);
			shape.graphics.endStroke();
			shape.x = 50;
			shape.y = 50;
			shape.skewX = 25;
			shape.skewY = 45;
			
			var koord = new Shape(); stage.addChild(koord);
			koord.graphics
				.beginStroke("green")
				.moveTo(shape.x, shape.y)
				.lineTo(shape.x + 30, shape.y)
				.moveTo(shape.x, shape.y)
				.lineTo(shape.x, shape.y + 30);
			
			
			var shape2 = shape.clone(); stage.addChild(shape2);
			shape2.x += 200;
			shape2.scaleY = 2;
			shape2.scaleX = 0.4;
			
			var koord2 = koord.clone(); stage.addChild(koord2);
			koord2.x += 200;*/
			
			stage.update();
		});
	}
}
