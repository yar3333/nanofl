import createjs.Point;
import nanofl.MovieClip;
import nanofl.TextField;

class Bucket extends BaseBucket
{
	var baseMovie : MovieClip;
	
	var fallProcessPhase = 0;	// 0 - nothing to do
								// 1 - moving to preffered position
								// 2 - rotation forward
								// 3 - waiting water to fall out
								// 4 - rotation backward
								// 5 - moving to mouse position
	
	var fillProcessDest : BaseBucket = null;
	var fillProcessFallFrame = 0;
	
	public function new(baseMovie:MovieClip, total:Int, x:Float)
	{
		super(total, new McBucket());
		
		this.baseMovie = baseMovie;
		baseMovie.addChild(mc);
		
		mc.x = x;
		mc.y = 345;
		
		mc.scaleX = mc.scaleY = Math.sqrt(total) * 40 / 100;
		
		setFill(0);
		
		activate(false);
	}
	
	public function activate(act:Bool)
	{
		var mcForeColor = mc.getChildByName("mcForeColor");
		mcForeColor.visible = act;
	}
	
	override public function getNeckPos() : createjs.Point
	{
		var mcNeck = mc.getChildByName("mcNeck");
		return new Point(mc.x + mcNeck.x * mc.scaleX, mc.y + mcNeck.y * mc.scaleY);
	}
	
	override public function setFill(v:Int)
	{
		fill = v;
		cast(mc.getChildByName("tfLabel"), TextField).text = fill + "/" + total;
		mc.gotoAndStop(Math.round(fill / total * 100));
	}
	
	function fallToBucket(dest:Bucket)
	{
		var freeDest = dest.total - dest.fill;
		if (freeDest > fill)
		{
			dest.setFill(dest.fill + fill);
			setFill(0);
		}
		else
		{
			dest.setFill(dest.total);
			setFill(fill - freeDest);
		}
	}
	
	// начинает анимированный процесс переливание из текущей бутыли в заданную
	public function startFallToBucketProcess(dest:BaseBucket)
	{
		if (fallProcessPhase != 0) { trace("StartFallProcess error 1"); return; }

		fallProcessPhase = 1;
		fillProcessDest = dest;
		fillProcessFallFrame = 0;
	}
	
	// должна вызываться на каждом кадре, пока процесс переливания идёт
	// (если будет вызвана когда процесс уже закончен - ничего страшного)
	// возвращает - закончен ли процесс переливания
	// mouseDX, mouseDY - смещение для последней фазы
	public function fallProcessStep(mouseDX:Float, mouseDY:Float) : Bool
	{
		if (fallProcessPhase == 0) return true;
		if (fallProcessPhase == 1)
		{
			var thisNeck = getNeckPos();
			var destNeck = fillProcessDest.getNeckPos();
			var b = mc.getChildByName("mcBox").getBounds();
			var mustPos = new Point(destNeck.x + b.height * mc.scaleY, destNeck.y);
			if (moveStepTo(mustPos, 6)) fallProcessPhase++;
		}
		else
		if (fallProcessPhase == 2)
		{
			if (fill == 0 || fillProcessDest.fill == fillProcessDest.total) fallProcessPhase++;
			else
			{
				if (mc.rotation > -90) mc.rotation -= 4;
				else fallProcessPhase++;
			}
		}
		else
		if (fallProcessPhase == 3)
		{
			if (fill == 0 || fillProcessDest.fill == fillProcessDest.total) fallProcessPhase++;
		}
		else
		if (fallProcessPhase == 4)
		{
			if (mc.rotation < 0) mc.rotation += 4;
			else fallProcessPhase++;
		}
		else
		if (fallProcessPhase == 5)
		{
			var r = moveStepTo(new Point(mc.stage.mouseX + mouseDX, mc.stage.mouseY + mouseDY), 10);
			if (r == true) fallProcessPhase = 0;
			return r;
		}
		
		if ((fallProcessPhase == 2 && mc.rotation<-40) || fallProcessPhase == 3)
		{
			fillProcessFallFrame++;
			if (fillProcessFallFrame % 7 == 6)
			{
				if (fill > 0 && fillProcessDest.fill < fillProcessDest.total)
				{
					setFill(fill - 1);
					fillProcessDest.setFill(fillProcessDest.fill + 1);
					Sounds.water();
				}
			}
		}
		
		return false;
	}
	
	public function moveStepTo(dest:createjs.Point, step:Float) : Bool
	{
		var dx = dest.x - mc.x;
		var dy = dest.y - mc.y;
		var len = Math.sqrt(dx * dx + dy * dy);
		if (len < step)
		{
			mc.x = dest.x;
			mc.y = dest.y;
			return true;
		}
		else
		{
			mc.x += dx / len * step;
			mc.y += dy / len * step;
			return false;
		}
	}
}
