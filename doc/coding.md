# Coding

For most things, you can just use [EaselsJS](http://www.createjs.com/Docs/EaselJS/modules/EaselJS.html) and
[SoundJS](http://www.createjs.com/Docs/SoundJS/modules/SoundJS.html) docs. Read below about NanoFL-specified features.
	
Important rules:
	
1. Most time you don't need to use `cache()` method: if your object have none empty `filters` then NanoFL cache it automatically.
2. If you need to uncache your object, don't forget to uncache dependent objects too (often this are the parent objects).
You can use `nanofl.DisplayObjectTools.smartUncache(myObj)` for this.
3. In most cases you don't need to create instances of `Bitmap`/`Button`/`MovieClip` directly. Use generated children classes in **src** folder for that.
	
NanoFL classes:

* [Bitmap](#Bitmap) - represent Bitmap Symbol on the canvas.
* [Button](#Button) - represent MovieClip Symbol with a button behavior (checked "Treat as button").
* [DisplayObjectTools](#DisplayObjectTools) - helpers applicable to `createjs.DisplayObject`.
* [MovieClip](#MovieClip) - represent MovieClip Symbol (EaselJS's MovieClip class does not used by NanoFL).
* [Player](#Player) - global store for CreateJS's stage and NanoFL's library and scene.
* [SeamlessSoundLoop](#SeamlessSoundLoop) - helper to play background music without gaps.
* [TextField](#TextField) - represent static and dynamic text on the canvas.
* [TextRun](#TextRun) - represent a formatted piece of text for `TextField`.


<a name="Bitmap"></a>

## nanofl.Bitmap

Extends [createjs.Bitmap](http://www.createjs.com/Docs/EaselJS/classes/Bitmap.html).
Just image on canvas.
Example:
```
var bmp = new nanofl.Bitmap(nanofl.Player.library.getItem("myBitmap"));
container.addChild(bmp);
```


<a name="Button"></a>

## nanofl.Button
Extends [nanofl.MovieClip](MovieClip).
Movie clip with 4 frames: *regular*, *mouse over*, *ouse pressed* and *hit area*.
Example:
```
var btn = new nanofl.Button(nanofl.Player.library.getItem("myButton"));
container.addChild(btn);
```


<a name="DisplayObjectTools"></a>

## nanofl.DisplayObjectTools
Helper methods applicable to `createjs.DisplayObject`.

### Static methods

* `smartCache(myObj:DiplayObject)` - cache objects in the tree (depend on filters and masks). In most cases NanoFL cache objects automatically.
* `smartUncache(myObj:DiplayObject)` - uncache `myObj` display object and dependent objects (depend on masks). In most cases NanoFL uncache objects automatically.
* `getOuterBounds(myObj:DiplayObject)` - returns object bounds include filters bounds (invariant to cache).
* `getInnerBounds(myObj:DiplayObject)` - returns object bounds exclude filters bounds (invariant to cache).
* `dump(myObj:DiplayObject)` - trace objects tree.

Examples:
```
nanofl.DisplayObjectTools.smartCache(myMovieClip);
nanofl.DisplayObjectTools.smartUncache(myMovieClip);
var bounds = nanofl.DisplayObjectTools.getOuterBounds(myMovieClip);
var bounds = nanofl.DisplayObjectTools.getInnerBounds(myMovieClip);
nanofl.DisplayObjectTools.dump(myMovieClip);
```


<a name="MovieClip"></a>

## nanofl.MovieClip

Extends [createjs.Container](http://www.createjs.com/Docs/EaselJS/classes/Container.html)

This is a special container to store layer-related children
(automatically when constructed from library symbol).
Also can contain children not related to any layer (so you can call `addChild()` to add your `DisplayObject` to `MovieClip`).

Example:
```
var mc = new nanofl.MovieClip(nanofl.Player.library.getItem("myMovieClip"));
container.addChild(mc);
```

### Fields
 * `paused` - a boolean to specify not to advance to the next frame on tick
 * `loop` - a boolean to specify go to the first frame on movie is finished
 * `currentFrame` - readonly integer which represent current frame index (zero-based)

### Methods

* `play()` - set `paused` to false
* `stop()` - set `paused` to true
* `gotoAndStop(labelOrIndex)` - go to specified frame and stop
* `gotoAndPlay(labelOrIndex`) - go to specified frame and play
* `getTotalFrames()` - returns most long layer length
* `onEnterFrame()` - override this method for your needs
* `onMouseDown(e:createjs.MouseEvent)` - override this method for your needs
* `onMouseMove(e:createjs.MouseEvent)` - override this method for your needs
* `onMouseUp(e:createjs.MouseEvent)` - override this method for your needs


<a name="Player"></a>

## nanofl.Player

This class is accessible anywhere. Use it to control global properties.

### Fields
 * `library` - a object with a 	`getItem(namePath)` method; use this method to get symbols from library
 * `stage` - a [createjs.Stage](http://www.createjs.com/Docs/EaselJS/classes/Stage.html) object (use to customize native CreateJS stage)
 * `scene` - a [nanofl.MovieClip](MovieClip) scene object (root movie clip)


<a name="SeamlessSoundLoop"></a>

## nanofl.SeamlessSoundLoop

Use this class for gapless background music loops.
Example:
```
var music = new nanofl.SeamlessSoundLoop(createjs.Sound.play("mySound"));
...
music.stop();

```

### Methods
 * `new(sound:createjs.AbstractSoundInstance)` - constructor
 * `stop()` - stop playing (create new object to start again)


<a name="TextField"></a>

## nanofl.TextField

This class represent a multi-line and multi-format text on canvas.
Example:
```
var tf = new nanofl.TextField();
tf.text = "My text";

```

### Fields
* `border` - set to `true` to show black border around text field
* `height` - current height of text field
* `minHeight` - minimal height calculated on text; readonly
* `minWidth` - minimal width calculated on text; readonly
* `text` - allow get or set whole text as a string
* `textRuns` - array of [TextRun](#TextRun) which contains field's text blocks
* `width` - current width of text field

### Methods
* `new()` - constructor


<a name="TextRun"></a>

## nanofl.TextRun

This class represent a piece of text and it's format. Used in TextField to store text blocks.

### Fields
* `align` - a string ("left", "right", "center" or "justify")
* `characters` - text string
* `family` - font family (like "Courier New")
* `fillColor` - fill color ("red", "#ff0000", "rgba(255, 0, 0, 0.5)")
* `kerning` - a boolean to do auto kerning
* `letterSpacing` - space between letters (ignored if kerning is on)
* `lineSpacing` - additional space between lines
* `size` - font size
* `strokeColor` - stroke color (used only if strokeSize > 0)
* `strokeSize` - stroke thickness (zero for regular text)
* `style` - font style ("", "bold", "italic" or "bold italic")

### Methods
* `new([characters], [fillColor], [size])` - constructor
* `clone()` - returns a copy of this object

----------------------------------------------------------------------------------------------------

<a href="https://bitbucket.org/nanofl/site/src/default/docs/api/index.md" target="_blank">Edit this page at bitbucket</a>