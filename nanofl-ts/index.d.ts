declare namespace nanofl
{
    class Library
    {
        getItem(namePath:string) : any;
    }

    class DisplayObjectTools
    {
        static cache(obj:createjs.DisplayObject) : void;
        static uncache(obj:createjs.DisplayObject) : void;
        static getBounds(obj:createjs.DisplayObject, ignoreSelf?:boolean) : createjs.Rectangle;
    }

    class Bitmap extends createjs.Bitmap
    {
        constructor(bitmapLibraryItem:any);
        
        onEnterFrame() : void;
        onMouseDown(e:createjs.MouseEvent) : void;
        onMouseMove(e:createjs.MouseEvent) : void;
        onMouseUp(e:createjs.MouseEvent) : void;
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
        onMouseDown(e:createjs.MouseEvent) : void;
        onMouseMove(e:createjs.MouseEvent) : void;
        onMouseUp(e:createjs.MouseEvent) : void;
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
        
        static init(canvas:HTMLCanvasElement, library:Library, framerate?:number, scaleMode?:string, textureAtlasesData?:Record<string, { images:string[], frames:number[] }>) : void;
    }
    
    class SeamlessSoundLoop
    {
        constructor(sound:createjs.AbstractSoundInstance);
        stop() : void;
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
}
