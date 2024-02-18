import createjs.Shape;
import createjs.Stage;
import js.Browser;
import js.html.CanvasElement;
import js.JQuery;
import nanofl.TextField;
import nanofl.TextRun;

class Main
{
	static public function main()
	{
		new JQuery(Browser.document).ready(function(e)
		{
			var canvas : CanvasElement = cast Browser.document.querySelector("#canvas");
			
			var stage = new Stage(canvas);
			
			var tf = new TextField(0, 0, true, false, true,
			[
				//TextRun.create("XabcY", "#000000", "Impact", "", 40, "center", 0, null, null),
				TextRun.create("Impact", "#000000", "Impact", "", 40, "center", 0, null, null),
				//TextRun.create("\nXabcY", "#000000", "Arial", "", 40, "center", 0, null, null),
			]);
			trace("tf.minHeight = " + tf.minHeight);
			//tf.height = 48;
			tf.x = 50;
			tf.y = 50;
			
			stage.addChild(tf);
			
			stage.update();
		});
	}
}
