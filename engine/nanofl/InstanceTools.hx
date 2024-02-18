package nanofl;

import easeljs.events.MouseEvent;

class InstanceTools
{
	public static function bindEventHandlers(instance:IInstance)
	{
        #if !ide
		Player.stage.addStagemousedownEventListener(stageMouseEventProxy.bind(instance, instance.onMouseDown));
		Player.stage.addStagemousemoveEventListener(stageMouseEventProxy.bind(instance, instance.onMouseMove));
		Player.stage.addStagemouseupEventListener(stageMouseEventProxy.bind(instance, instance.onMouseUp));
        #end
	}
	
	static function stageMouseEventProxy(instance:IInstance, f:MouseEvent->Void, e:MouseEvent)
	{
		var t = e.currentTarget;
		e.currentTarget = instance;
		f(e);
		e.currentTarget = t;
	}
}