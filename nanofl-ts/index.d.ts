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
        static cache(obj:createjs.DisplayObject) : void;
        static uncache(obj:createjs.DisplayObject) : void;
        static getBounds(obj:createjs.DisplayObject, ignoreSelf?:boolean) : createjs.Rectangle;
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
        
        static init(canvas:HTMLCanvasElement, library:Library, framerate?:number, scaleMode?:string, textureAtlasesData?:Record<string, { images:string[], frames:number[] }>) : void;
    }
    
    class SeamlessSoundLoop
    {
        constructor(audio:HTMLAudioElement);
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
    
    interface PlayPropsConfig
    {
        /**
         * How to interrupt any currently playing instances of audio with the same source, if the maximum number of instances of the sound are already playing.
         * Values are defined as INTERRUPT_TYPE constants on the Sound class, with the default defined by defaultInterruptBehavior.
         * 
         * createjs.Sound.INTERRUPT_***
         */
        interrupt?: any;
        
        /**
         * The amount of time to delay the start of audio playback, in milliseconds.
         */
        delay?: number;

        /**
         * The offset from the start of the audio to begin playback, in milliseconds.
         */
        offset?: number;
        
        /**
         * How many times the audio loops when it reaches the end of playback. The default is 0 (no loops), and -1 can be used for infinite playback.
         */
        loop?: number;
        
        /**
         * The volume of the sound, between 0 and 1. Note that the master volume is applied against the individual volume.
         */
        volume?: number;
        
        /**
         * The left-right pan of the sound (if supported), between -1 (left) and 1 (right).
         */
        pan?: number;
        
        /**
         * To create an audio sprite (with duration), the initial offset to start playback and loop from, in milliseconds.
         */
        startTime?: number;
        
        /**
         * To create an audio sprite (with startTime), the amount of time to play the clip for, in milliseconds.
         */
        duration?: number;
    }   
}
