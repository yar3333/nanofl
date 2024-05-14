/// <reference types="@types/createjs" />
/// <reference types="@types/three" />

declare namespace nanofl
{
    class Library
    {
        getItem(namePath:string) : any;
    }
    
    class MouseEvent
    {
		readonly stageX : number;
		readonly stageY : number;
		
        readonly localX : number;
		readonly localY : number;
		
		cancel() : void;
    }

    class DisplayObjectTools
    {
        static recache(obj:createjs.DisplayObject, force?:boolean) : boolean;
        static cache(obj:createjs.DisplayObject) : void;
        static getOuterBounds(obj:createjs.DisplayObject, ignoreSelf?:boolean) : createjs.Rectangle;
        static getInnerBounds(obj:createjs.DisplayObject) : createjs.Rectangle;
    }

    class Bitmap extends createjs.Bitmap
    {
        constructor(bitmapLibraryItem:any);
        
        onEnterFrame() : void;
        onMouseDown(e:nanofl.MouseEvent) : void;
        onMouseMove(e:nanofl.MouseEvent) : void;
        onMouseUp(e:nanofl.MouseEvent) : void;
    }

    class MovieClip extends createjs.Container
    {
        paused : boolean;
        loop : boolean;
        
        currentFrame : number;
        
        constructor(movieClipLibraryItem:any);
        
        play() : void;
        stop() : void;
        gotoAndStop(labelOrIndex:string|number) : void;
        gotoAndPlay(labelOrIndex:string|number) : void;
        getTotalFrames() : number;
        
        onEnterFrame() : void;
        onMouseDown(e:nanofl.MouseEvent) : void;
        onMouseMove(e:nanofl.MouseEvent) : void;
        onMouseUp(e:nanofl.MouseEvent) : void;
    }    

    class Button extends MovieClip
    {
        constructor(buttonLibraryItem:any);
    }

    class Player
    {
        static readonly library : Library;
        static readonly stage : createjs.Stage;
        static readonly scene : nanofl.MovieClip;
        static readonly spriteSheets : Record<string, createjs.SpriteSheet>;
        static readonly lifetime : Number;
        
        static init(args:{
            container:HTMLDivElement, 
            libraryData:any, 
            framerate?:number, 
            scaleMode?:string, 
            textureAtlasesData?:Record<string, { images:string[], frames:number[] }>,
            clickToStart?:Boolean,
        }) : Promise<void>;
    }
    
    class TextField extends createjs.Container
    {
        border : boolean;
        height : number;
        minHeight : number;
        minWidth : number;
        text : string;
        textRuns : TextRun[];
        width : number;
        
        constructor();
    }

    class TextRun
    {
        align : string;
        characters : string;
        family : string;
        fillColor : string;
        kerning : boolean;
        letterSpacing : number;
        lineSpacing : number;
        size : number;
        strokeColor : string;
        strokeSize : number;
        style : string;
        
        constructor(characters?:string, fillColor?:string, size?:number);
        
        clone() : nanofl.TextRun;
    }
    
    class Mesh extends createjs.Container
    {
        static readonly DEG_TO_RAD : number;
        
        rotationX : number;
        rotationY : number;
        rotationZ : number;
        
        scene : THREE.Scene;
        group : THREE.Group;
        
        camera : THREE.PerspectiveCamera;
        autoCamera : boolean;
        
        ambientLight : THREE.AmbientLight;
        directionalLight : THREE.DirectionalLight;
        
        constructor(meshLibraryItem:any);
        
        /**
         * Called automaticaly before draw.
         */
        update() : void;
    }

    class SolidContainer extends createjs.Container
    {
    }

    class Video extends nanofl.SolidContainer
    {
        readonly symbol : any;
        readonly video : HTMLVideoElement;
        readonly duration : Number;
        
        constructor(videoLibraryItem:any);
        
        onEnterFrame() : void;
        onMouseDown(e:nanofl.MouseEvent) : void;
        onMouseMove(e:nanofl.MouseEvent) : void;
        onMouseUp(e:nanofl.MouseEvent) : void;
    }    
}
