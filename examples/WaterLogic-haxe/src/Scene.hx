class Scene extends base.Scene
{
	var lastInitFrame : Int = null;
	
	override public function onEnterFrame()
	{
		if (currentFrame != lastInitFrame)
		{
			lastInitFrame = currentFrame;
			addButtonHandler("btGotoGame", function() gotoAndStop("Game"));
			addButtonHandler("btRules", function() gotoAndStop("Rules"));
			addButtonHandler("btScores", function() gotoAndStop("Scores"));
			addButtonHandler("btGotoOrigin", function() gotoAndStop("Origin"));
		}
	}
	
	function addButtonHandler(name:String, f:Void->Void)
	{
		var bt = getChildByName(name);
		if (bt != null) bt.addClickEventListener(function(e) f());
	}
}