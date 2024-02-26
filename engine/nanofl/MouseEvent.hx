package nanofl;

import js.Syntax;
import easeljs.display.DisplayObject;
import easeljs.geom.Point;

@:build(JsProp.marked())
class MouseEvent
{
    public var canceled = false;
    
    public var stageX(default, null) : Float;
    public var stageY(default, null) : Float;

    public function cancel() : Void { canceled = true; }

    public var _target : DisplayObject;
    
    var _local : Point;

    @:property
    public var localX(get, never) : Float;
    function get_localX()
    {
        if (Syntax.typeof(this._local) == "undefined")
        {
            _local = _target.globalToLocal(stageX, stageY);
        }
        return _local.x;
    }

    @:property
    public var localY(get, never) : Float;
    function get_localY()
    {
        if (Syntax.typeof(this._local) == "undefined")
        {
            _local = _target.globalToLocal(stageX, stageY);
        }
        return _local.y;
    }

    public function new(stageX:Float, stageY:Float)
    {
        this.stageX = stageX;
        this.stageY = stageY;
    }
}