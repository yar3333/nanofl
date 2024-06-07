const { app, screen } = require('electron/main');
const path = require('path');
const fs = require('node:fs');

function loadOptions()
{
    let options = {};

    try {
        options = JSON.parse(fs.readFileSync(path.join(app.getPath("userData"), "config.json"), { encoding: 'utf8' }));
    }
    catch (err) {}

    if (!options.windowBounds) options.windowBounds = { x:0, y:0 };
    if (!options.windowBounds.x) options.windowBounds.x = 0;
    if (!options.windowBounds.y) options.windowBounds.y = 0;

    const display = screen.getDisplayNearestPoint({ x:options.windowBounds.x, y:options.windowBounds.y });
    if (!(options.windowBounds.x > display.bounds.x && options.windowBounds.x < display.size.width) 
     || !(options.windowBounds.y > display.bounds.y && options.windowBounds.y < display.size.height))
    {
        options.windowBounds.x = display.bounds.x
        options.windowBounds.y = display.bounds.y
    }

    return options;
}

function saveOptions(options, win)
{
    const newOptions =
    {
        windowIsMaximized: win.isMaximized(),
        windowBounds: win.isMaximized() ? options.windowBounds : win.getBounds()
    }
    fs.writeFileSync(path.join(app.getPath("userData"), "config.json"), JSON.stringify(newOptions, null, "\t"), { encoding: 'utf8' });
}

module.exports =
{ 
    loadOptions,
    saveOptions,
};
