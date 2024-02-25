# NanoFL

HTML5 vector editor and animator. Help your to create animated banners, movie clips and games.

* [Quick start](doc/quick_start/index.md)

## Features

### 2D Graphics
* Vector: edges, polygons and boolean operations
* Raster: `png`, `jpeg`, rasterized `svg`
* Layers: groups, masks, tweens, guides
* Effects: alpha, brightness, tint, advanced
* Filters: Adjust Color, Blur, Drop Shadow, Glow
* Linear and radial gradients, filling with a bitmap

### Text
* Text on canvas: styles, stroke
* Local `woff2` fonts
* Import fonts from [Google Fonts](https://fonts.google.com/)
 
### [Coding](doc/coding.md)
* Based on [EaselJS](https://createjs.com/easeljs) library
* Just `application.js` file
* Template for [TypeScript](https://www.typescriptlang.org/) and [VS Code](https://code.visualstudio.com/)

### 3D Graphics
* Based on [ThreeJS](https://threejs.org/) library
* Loading `GLTF` files
* Autoconvertion from Blender's `blend` to `GLTF`

### Texture atlases
* [Generate texture atlases](/doc/generate_texture_atlases/index.md)

### Sounds
* Seamless loops
* Generate `ogg` on publish

### Import plugins
* [Adobe Flash Documents](/doc/flash/) (`*.fla;*.xfl`)
* [SVG](/doc/svg/) (`*.svg`)

### Export plugins
* [SVG](/doc/svg/) (`*.svg`)
* Image (`png`, `jpg`)
* Image sequence (`png`, `jpg`)
* Video (`mp4`) via FFMPEG

### And more
* [Batch processing](/doc/command_line/)
* Plugin system (Filters, Importers, Exporters, library item Loaders)
* [Scale Mode](/doc/scale_mode/) support

## Credits
* [CreateJS](http://www.createjs.com/) framework, gskinner
* [ThreeJS](https://threejs.org/) library, three.js authors
* [jQuery](http://jquery.com/) framework, jQuery Foundation
* [FFmpeg](https://ffmpeg.org/), FFmpeg contributors
* [Silk Icons](http://www.famfamfam.com/lab/icons/silk/), Mark James
