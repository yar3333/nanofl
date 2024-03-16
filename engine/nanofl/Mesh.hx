package nanofl;

import js.html.CanvasRenderingContext2D;
import easeljs.display.Bitmap;
import js.three.lights.AmbientLight;
import js.three.lights.DirectionalLight;
import js.three.math.Euler;
import js.three.objects.Group;
import js.three.cameras.PerspectiveCamera;
import js.three.math.Vector3;
import js.three.renderers.WebGLRenderer;
import js.three.scenes.Scene;
import nanofl.engine.MeshParams;
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
	
	public var renderer(default, null) : WebGLRenderer;
    public var bitmap(default, null) : Bitmap;
    public var scene(default, null) : Scene;
	public var group(default, null) : Group;
	
	public var camera : PerspectiveCamera;
	public var autoCamera : Bool;
	
	public var ambientLight(default, null) : AmbientLight;
	public var directionalLight(default, null) : DirectionalLight;
	
	public function new(symbol:MeshItem, params:MeshParams)
	{
		super();
        
        rotationX = 0.0;
        rotationY = 0.0;
        rotationZ = 0.0;
        
        camera = new PerspectiveCamera(70, 1, 0, 1e7);
        autoCamera = true;
                
        ambientLight = new AmbientLight(0xE0E0E0);
        directionalLight = new DirectionalLight(0x808080, 1);
        
		this.symbol = symbol;
		
		var d = MeshItem.DISPLAY_OBJECT_SIZE >> 1;
		setBounds(-d, -d, MeshItem.DISPLAY_OBJECT_SIZE, MeshItem.DISPLAY_OBJECT_SIZE);

        renderer = new WebGLRenderer({ alpha:true, antialias:true });
        
        bitmap = new Bitmap(renderer.domElement);
        bitmap.x = bitmap.y = -d;
        addChild(bitmap);
        
        setQuality(2);
		
		scene = new Scene();
		
		group = new Group();
		for (object in symbol.scene.children)
		{
			switch (object.type)
			{
				case AmbientLight, DirectionalLight, SpotLight, PointLight, HemisphereLight, RectAreaLight:
					if (symbol.loadLights)
					{
						group.add(object.clone());
					}
					
				case _:
					group.add(object.clone());
			}
		}
        scene.add(group);

        scene.add(ambientLight);
		scene.add(directionalLight);

        if (params != null) MeshParamsTools.applyToMesh(params, this);
	}

    /**
        Scale factor for rendering area (256x256). Default is 2.0.
    **/
    public function setQuality(q:Float)
    {
        final sz = Math.round(MeshItem.DISPLAY_OBJECT_SIZE * q);
        renderer.setSize(sz, sz);
        bitmap.scaleX = bitmap.scaleY = 1 / q;
    }
	
	override public function clone(?recursive:Bool) : Mesh
	{
		final r : Mesh = (cast this)._cloneProps(new Mesh(symbol, null));

        r.rotationX = rotationX;
        r.rotationY = rotationY;
        r.rotationZ = rotationZ;
        r.camera = cast camera?.clone();
        r.autoCamera = autoCamera;
        r.ambientLight = cast ambientLight.clone();
        r.directionalLight = cast directionalLight.clone();

        return r;
	}
	
	override public function toString() : String 
	{
		return symbol.toString();
	}
	
	override public function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool) : Bool
	{
        group.setRotationFromEuler(new Euler(rotationX * DEG_TO_RAD, rotationY * DEG_TO_RAD, rotationZ * DEG_TO_RAD));
		group.updateMatrix();
        
		final posZ = symbol.boundingRadius / Math.sin(camera.fov / 2 * DEG_TO_RAD);
		
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
		


		renderer.render(scene, camera);

		return super.draw(ctx, ignoreCache);
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