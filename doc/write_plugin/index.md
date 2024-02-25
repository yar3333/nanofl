# Write plugin

NanoFL has several points to be extended by plugins.
You can write plugin on TypeScript or Haxe (or even on pure JavaScript).
Using NanoFL PluginAPI declaration files (`nanofl.d.ts` for TypeScript and `*.hx` for Haxe) making development simple.

Each plugin is a class inside a `*.js` file in **plugins** application folder.
Also, this folder may contain a directory with plugin-related files.
By convection, that directory must be named same as a plugin.

There are several types of the plugins are supported:

* [Loader](#loader) - loading library items from files;
* [Importer](#importer) - importing from third-party formats into NanoFL documents;
* [Exporter](#exporter) - exporting from NanoFL documents into third-party formats;
* [Filter](#filter) - a raster transformation for a symbol instances;
* [Generator](#generator) - generating files on save (compiling, publishing);


<a name="loader"></a>

## Loader
Loader plugin is a class which implements `nanofl.ide.plugins.ILoaderPlugin` interface.

Plugin file must contain registration code (executed on plugin load):
```
nanofl.engine.Plugins.registerLoader(new MyPluginClass());

```

For example of the loader plugin written on Haxe, see [StdLoadersPlugin](https://bitbucket.org/nanofl/plugins/src/default/StdLoadersPlugin).

<a name="importer"></a>

## Importer
Importer plugin is a class which implements `nanofl.ide.plugins.IImporterPlugin` interface.
The main method of this class, called by NanoFL IDE, is `importDocument`.
This method must store imported data to received `documentProperties` and `library` objects.
If you need to save media files - use a path from `library.libraryDir`.

Plugin file must contain registration code (executed on plugin load):
```
nanofl.engine.Plugins.registerImporter(new MyPluginClass());

```

For example of the importer plugin written on Haxe, see [FlashImporterPlugin](https://bitbucket.org/nanofl/plugins/src/default/FlashImporterPlugin).


<a name="exporter"></a>

## Exporter
Exporter plugin is a class which implements `nanofl.ide.plugins.IExporterPlugin` interface.
The main method of this class, called by NanoFL IDE, is `exportDocument`.
This method must store data from received `documentProperties` and `library` objects to files of desired format.
If you need to get base path to media files - use `library.libraryDir`.

Plugin file must contain registration code (executed on plugin load):
```
nanofl.engine.Plugins.registerExporter(new MyPluginClass());

```

For example of the exporter plugin written on Haxe, see [SvgExporterPlugin](https://bitbucket.org/nanofl/plugins/src/default/SvgExporterPlugin).


<a name="filter"></a>

## Filter
Filter plugin allow you create visual effects for symbols on the scene.
NanoFL contains [StdFiltersPlugin](https://bitbucket.org/nanofl/plugins/src/default/StdFiltersPlugin) which register several filters:

* [Adjust Color](https://bitbucket.org/nanofl/plugins/src/default/StdFiltersPlugin/src/AdjustColorFilterPlugin.hx) - tune brightness/contrast;
* [Blur](https://bitbucket.org/nanofl/plugins/src/default/StdFiltersPlugin/src/BlurFilterPlugin.hx) - bluring effect;
* [Drop Shadow](https://bitbucket.org/nanofl/plugins/src/default/StdFiltersPlugin/src/DropShadowFilterPlugin.hx) - draw a shadow;
* [Glow](https://bitbucket.org/nanofl/plugins/src/default/StdFiltersPlugin/src/GlowFilterPlugin.hx) - glowing effect.

Each plugin's filter class must implement `nanofl.engine.plugins.IFilterPlugin` and have two main points:

* `properties` - array of special objects which describe plugin parameters (user can tune these parameters in NanoFL IDE);
* `getFilter` - method to get instance of EaselJS's [Filter](http://createjs.com/Docs/EaselJS/classes/Filter.html) class.

Plugin file must contain registration code (executed on plugin load):
```
nanofl.engine.Plugins.registerFilter(new MyPluginClass());

```

The source code of the filter plugin concatenated to generated result file (`*.html` or `*.js`)
if at least one of the plugin's filters was used in NanoFL document.

<a name="generator"></a>

## Generator
Generator plugin is a class which implements `nanofl.ide.plugins.IGeneratorPlugin` interface.
The main method of this class, called by NanoFL IDE, is `generate`.
This method must generate files from received `documentProperties` and `library` objects.

Plugin file must contain registration code (executed on plugin load):
```
nanofl.engine.Plugins.registerGenerator(new MyPluginClass());

```

For example of the generator plugin written on Haxe, see [CreateJSGeneratorPlugin](https://bitbucket.org/nanofl/plugins/src/default/CreateJSGeneratorPlugin).

----------------------------------------------------------------------------------------------------
<a href="https://bitbucket.org/nanofl/site/src/default/docs/write_plugin/index.md" target="_blank">Edit this page at bitbucket</a>