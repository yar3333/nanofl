package nanofl.engine;

import js.three.math.Euler;
import js.three.math.Color;
using stdlib.Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

typedef MeshParams =
{
	@:optional var rotationX : Float; // 0.0
	@:optional var rotationY : Float; // 0.0
	@:optional var cameraFov : Float; // 70
	@:optional var ambientLightColor : String; // "#E0E0E0"
	@:optional var directionalLightColor : String; // "#808080"
	@:optional var directionalLightRotationX : Float; // 0.0
	@:optional var directionalLightRotationY : Float; // 0.0
}

class MeshParamsTools
{
    public static function createDefault() : MeshParams
    {
        return 
        {
            rotationX : 0.0,
            rotationY : 0.0,
            cameraFov : 70.0,
            ambientLightColor : "#E0E0E0",
            directionalLightColor : "#808080",
            directionalLightRotationX : 0.0,
            directionalLightRotationY : 0.0,
        }
    }
	
    #if ide
    public static function load(node:HtmlNodeElement) : MeshParams
	{
		var r = createDefault();
		
		r.rotationX = node.getAttrFloat("rotationX", r.rotationX);
		r.rotationY = node.getAttrFloat("rotationY", r.rotationY);
		r.cameraFov = node.getAttrFloat("cameraFov", r.cameraFov);
		r.ambientLightColor = node.getAttrString("ambientLightColor", r.ambientLightColor);
		r.directionalLightColor = node.getAttrString("directionalLightColor", r.directionalLightColor);
		r.directionalLightRotationX = node.getAttrFloat("directionalLightRotationX", r.directionalLightRotationX);
		r.directionalLightRotationY = node.getAttrFloat("directionalLightRotationY", r.directionalLightRotationY);
		
		return r;
	}
    #end

	public static function loadJson(obj:Dynamic) : MeshParams
    {
		var r = createDefault();
        if (obj == null) return r;
		
		r.rotationX = obj.rotationX ?? r.rotationX;
		r.rotationY = obj.rotationY ?? r.rotationY;
		r.cameraFov = obj.cameraFov ?? r.cameraFov;
		r.ambientLightColor = obj.ambientLightColor ?? r.ambientLightColor;
		r.directionalLightColor = obj.directionalLightColor ?? r.directionalLightColor;
		r.directionalLightRotationX = obj.directionalLightRotationX ?? r.directionalLightRotationX;
		r.directionalLightRotationY = obj.directionalLightRotationY ?? r.directionalLightRotationY;
		
		return r;
    }
    
    #if ide
	public static function save(params:MeshParams, out:XmlBuilder)
	{
		var def = createDefault();
		
		out.attr("rotationX", params.rotationX, def.rotationX);
		out.attr("rotationY", params.rotationY, def.rotationY);
		out.attr("cameraFov", params.cameraFov, def.cameraFov);
		out.attr("ambientLightColor", params.ambientLightColor, def.ambientLightColor);
		out.attr("directionalLightColor", params.directionalLightColor, def.directionalLightColor);
		out.attr("directionalLightRotationX", params.directionalLightRotationX, def.directionalLightRotationX);
		out.attr("directionalLightRotationY", params.directionalLightRotationY, def.directionalLightRotationY);
	}

    public static function saveJson(params:MeshParams) : Dynamic
    {
		var def = createDefault();
        
        return
        {
            rotationX : params.rotationX ?? def.rotationX,
            rotationY : params.rotationY ?? def.rotationY,
            cameraFov : params.cameraFov ?? def.cameraFov,
            ambientLightColor : params.ambientLightColor ?? def.ambientLightColor,
            directionalLightColor : params.directionalLightColor ?? def.directionalLightColor,
            directionalLightRotationX : params.directionalLightRotationX ?? def.directionalLightRotationX,
            directionalLightRotationY : params.directionalLightRotationY ?? def.directionalLightRotationY,
        };
    }
    #end
	
	public static function equ(a:MeshParams, b:MeshParams) : Bool
	{
        if (a == b) return true;
        
        if (a == null) a = createDefault();
        if (b == null) b = createDefault();
		
        return a.rotationX == b.rotationX
			&& a.rotationY == b.rotationY
			&& a.cameraFov == b.cameraFov
			&& a.ambientLightColor == b.ambientLightColor
			&& a.directionalLightColor == b.directionalLightColor
			&& a.directionalLightRotationX == b.directionalLightRotationX
			&& a.directionalLightRotationY == b.directionalLightRotationY;
	}
	
	public static function clone(params:MeshParams) : MeshParams
	{
        if (params == null) return null;

		var r = createDefault();
		
		r.rotationX = params.rotationX;
		r.rotationY = params.rotationY;
		r.cameraFov = params.cameraFov;
		r.ambientLightColor = params.ambientLightColor;
		r.directionalLightColor = params.directionalLightColor;
		r.directionalLightRotationX = params.directionalLightRotationX;
		r.directionalLightRotationY = params.directionalLightRotationY;
		
		return r;
	}
	
	public static function applyToMesh(params:MeshParams, mesh:nanofl.Mesh)
	{
		mesh.rotationX = params.rotationX;
		mesh.rotationY = params.rotationY;
		mesh.camera.fov = params.cameraFov;
		mesh.ambientLight.color = new Color(ColorTools.stringToNumber(params.ambientLightColor));
		mesh.directionalLight.color = new Color(ColorTools.stringToNumber(params.directionalLightColor));
		mesh.directionalLight.setRotationFromEuler(new Euler(params.directionalLightRotationX * Math.PI / 180, params.directionalLightRotationY * Math.PI / 180));
	}
}