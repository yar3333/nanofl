package nanofl;

import js.html.CanvasRenderingContext2D;
import js.three.lights.AmbientLight;
import js.three.lights.DirectionalLight;
import js.three.math.Euler;
import js.three.objects.Group;
import js.three.cameras.PerspectiveCamera;
import js.three.scenes.Scene;
import js.three.math.Vector3;
import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.libraryitems.MeshItem;

@:expose
#if profiler @:build(Profiler.buildMarked()) #end
//@:build(JsProp.marked())
class Mesh extends SolidContainer 
    implements InstanceDisplayObject
    #if !ide implements IEventHandlers #end
{
	static var DEG_TO_RAD = Math.PI / 180;
	
	public var symbol(default, null) : MeshItem;
	
	public var rotationX : Float;
	public var rotationY : Float;
	public var rotationZ : Float;
	
	public var scene : Scene;
	public var group : Group;
	
	public var camera(default, null) : PerspectiveCamera;
	public var autoCamera : Bool;
	
	public var ambientLight(default, null) : AmbientLight;
	public var directionalLight(default, null) : DirectionalLight;
	
	public function new(symbol:MeshItem)
	{
		super();
        
        rotationX = 0.0;
        rotationY = 0.0;
        rotationZ = 0.0;
        
        camera = new PerspectiveCamera(70, 1, 0, 1e7);
        autoCamera = true;
                
        ambientLight = new AmbientLight(0xE0E0E0);
        directionalLight = new DirectionalLight(0x808080, 1);
        
        #if profiler Profiler.measure("Mesh.new", function() { #end
		
		this.symbol = symbol;
		
		var d = symbol.renderAreaSize >> 1;
		if (symbol.renderAreaSize % 2 != 0) d++;
		setBounds(-d, -d, d, d);
		
		symbol.updateDisplayObject(this, null);
		
		#if profiler }); #end
	}
	
	override public function clone(?recursive:Bool) : Mesh
	{
		return (cast this)._cloneProps
		(
			new Mesh(symbol)
		);
	}
	
	override public function toString() : String 
	{
		return symbol.toString();
	}
	
	override public function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool) : Bool
	{
		update();
		return super.draw(ctx, ignoreCache);
	}
	
	@:profile
	public function update()
	{
		#if profiler Profiler.measure("Mesh.update", "scene", function() { #end
		
		removeAllChildren();
		var bitmap = new easeljs.display.Bitmap(symbol.renderer.domElement);
		addChild(bitmap);
		bitmap.x = bitmap.y = -symbol.renderAreaSize / 2;
		
		group.setRotationFromEuler(new Euler(rotationX * DEG_TO_RAD, rotationY * DEG_TO_RAD, rotationZ * DEG_TO_RAD));
		group.updateMatrix();
        
		var posZ = symbol.boundingRadius / Math.sin(camera.fov / 2 * DEG_TO_RAD);
		
		if (directionalLight != null)
		{
			directionalLight.position.x = 0.0;
			directionalLight.position.y = 0.0;
			directionalLight.position.z = -posZ;
			directionalLight.position.applyEuler(new Euler(directionalLight.rotation.x, directionalLight.rotation.y));
		}
        
		if (autoCamera)
		{
			camera.position.z = -posZ;
			camera.lookAt(new Vector3(0, 0, 0));
			camera.near = posZ - symbol.boundingRadius;
			camera.far  = posZ + symbol.boundingRadius;
			camera.updateProjectionMatrix();
			camera.updateMatrix();
		}
		
		#if profiler }); #end
		
		if (ambientLight != null) scene.add(ambientLight);
		if (directionalLight != null) scene.add(directionalLight);
		
		#if profiler Profiler.measure("Mesh.update", "render", function() { #end
		
		// #if ide
		// var oldWarn = nanofl.engine.Console.filter("warn", function(vv)
		// {
		// 	return vv[0] != "THREE.WebGLProgram: gl.getProgramInfoLog()" || !vv[1] || vv[1].indexOf("fakepath(106,3-100): warning X3557:") < 0;
		// });
		// #end
		
		symbol.renderer.render(scene, camera);
		
		// #if ide
		// if (oldWarn != null)
		// {
		// 	(cast js.Browser.console).warn = oldWarn;
		// }
		// #end
		
		#if profiler }); #end
	}
	
	#if !ide
	
	//{ IEventHandlers
	public function onEnterFrame() : Void {}
	public function onMouseDown(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseMove(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseUp(e:easeljs.events.MouseEvent) : Void {}
	//}
	
	#end
}