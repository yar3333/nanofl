# NanoFL command-line


## Normal mode
In normal mode IDE starts as usual and support interactions with user after command-line arguments processing.
Don't use this in batch processing due to some limits (not support relative file paths, process can exit without waiting real IDE closing, exit code may be wrong).
```
NanoFL.exe <options>
```


## Batch mode
Use next command to run NanoFL in batch mode (advantages: waiting for exit, correct exit code and relative paths support):
```
nanoflc.exe <options>
```


## Options

Options sequence is important: NanoFL process options consecutive from the first to the last. Next options are supported:

* `<path to the document to load/import>` - Just load specified document into editor.
* `<path to js/jsnf script file to execute>` - Load specified JavaScript file and execute the code.
* `-export <output file path>` - Export or save current document depends on output file extension.
* `-resize-fit <width>x<height>` - Resize document to fit specified size. `<width>` or `<height>` can be ommited.
* `-generator <name>,<param1>=<value1>,<param2>=<value2>...` - Set document's generator and its parameters.
* `-scaleMode <mode>` - Set document's [scale mode](/docs/scaleMode/) (`noScale`, `fit`, `fill`, `stretch` and `custom` are supported). Default is `noScale`.
* `-script <inline_js_code>` - Evalute specified js code. See [scripts](/docs/scripts/).
* `-fps` - Show frames per second HUD.
* `-jsconsole` - Show debug console.


## Examples:

```
# import Flash document and save as NanoFL document
nanoflc.exe c:\myflash\myflash.xfl -export c:\mynanofl\mynanofl.nfl

# load NanoFL document and export as PNG image
nanoflc.exe c:\mynanofl\mynanofl.nfl -export c:\myimage.png
```
