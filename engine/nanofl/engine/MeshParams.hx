package nanofl.engine;

import js.three.math.Euler;
import js.three.math.Color;
using stdlib.Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class MeshParams
{
	public var rotationX = 0.0;
	public var rotationY = 0.0;
	public var cameraFov = 70;
	public var ambientLightColor = "#E0E0E0";
	public var directionalLightColor = "#808080";
	public var directionalLightRotationX = 0.0;
	public var directionalLightRotationY = 0.0;
	
	public function new() {}
	
	#if ide
    public static function load(node:HtmlNodeElement) : MeshParams
	{
		var r = new MeshParams();
		
		r.rotationX = node.getAttrFloat("rotationX", r.rotationX);
		r.rotationY = node.getAttrFloat("rotationY", r.rotationY);
		r.cameraFov = node.getAttrInt("cameraFov", r.cameraFov);
		r.ambientLightColor = node.getAttrString("ambientLightColor", r.ambientLightColor);
		r.directionalLightColor = node.getAttrString("directionalLightColor", r.directionalLightColor);
		r.directionalLightRotationX = node.getAttrFloat("directionalLightRotationX", r.directionalLightRotationX);
		r.directionalLightRotationY = node.getAttrFloat("directionalLightRotationY", r.directionalLightRotationY);
		
		return r;
	}
    #end

	public static function loadJson(obj:Dynamic) : MeshParams
    {
		var r = new MeshParams();
		
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
	public function save(out:XmlBuilder)
	{
		var def = new MeshParams();
		
		out.attr("rotationX", rotationX, def.rotationX);
		out.attr("rotationY", rotationY, def.rotationY);
		out.attr("cameraFov", cameraFov, def.cameraFov);
		out.attr("ambientLightColor", ambientLightColor, def.ambientLightColor);
		out.attr("directionalLightColor", directionalLightColor, def.directionalLightColor);
		out.attr("directionalLightRotationX", directionalLightRotationX, def.directionalLightRotationX);
		out.attr("directionalLightRotationY", directionalLightRotationY, def.directionalLightRotationY);
	}

    public function saveJson() : Dynamic
    {
		var def = new MeshParams();
        
        return
        {
            rotationX = rotationX ?? def.rotationX;
            rotationY = rotationY ?? def.rotationY;
            cameraFov = cameraFov ?? def.cameraFov;
            ambientLightColor = ambientLightColor ?? def.ambientLightColor;
            directionalLightColor = directionalLightColor ?? def.directionalLightColor;
            directionalLightRotationX = directionalLightRotationX ?? def.directionalLightRotationX;
            directionalLightRotationY = directionalLightRotationY ?? def.directionalLightRotationY;
        };
    }
    #end
	
	public function equ(obj:MeshParams) : Bool
	{
		return obj.rotationX == rotationX
			&& obj.rotationY == rotationY
			&& obj.cameraFov == cameraFov
			&& obj.ambientLightColor == ambientLightColor
			&& obj.directionalLightColor == directionalLightColor
			&& obj.directionalLightRotationX == directionalLightRotationX
			&& obj.directionalLightRotationY == directionalLightRotationY;
	}
	
	public function clone() : MeshParams
	{
		var r = new MeshParams();
		
		r.rotationX = rotationX;
		r.rotationY = rotationY;
		r.cameraFov = cameraFov;
		r.ambientLightColor = ambientLightColor;
		r.directionalLightColor = directionalLightColor;
		r.directionalLightRotationX = directionalLightRotationX;
		r.directionalLightRotationY = directionalLightRotationY;
		
		return r;
	}
	
	public function applyToMesh(mesh:nanofl.Mesh)
	{
		mesh.rotationX = rotationX;
		mesh.rotationY = rotationY;
		mesh.camera.fov = cameraFov;
		mesh.ambientLight.color = new Color(ColorTools.stringToNumber(ambientLightColor));
		mesh.directionalLight.color = new Color(ColorTools.stringToNumber(directionalLightColor));
		mesh.directionalLight.setRotationFromEuler(new Euler(directionalLightRotationX * Math.PI / 180, directionalLightRotationY * Math.PI / 180));
	}
}