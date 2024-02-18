package nanofl;

@:expose
class Stage extends easeljs.display.Stage
{
	public function new(canvas:Dynamic) 
	{
		super(canvas);
		tickOnUpdate = false;
		
		#if !ide
		enableMouseOver(10);
		#end
	}
	
	override public function update(?params:Dynamic)
	{
		DisplayObjectTools.smartCache(this);
		super.update(params);
	}
}