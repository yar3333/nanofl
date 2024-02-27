const { app, BrowserWindow, ipcMain, dialog, clipboard, screen, shell, utilityProcess } = require('electron/main');
const path = require('path');
const fs = require('node:fs');

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let win;
var options;

function createWindow () {
  loadOptions();
  
  win = new BrowserWindow({
    x: options.windowBounds.x,
    y: options.windowBounds.y,
	width: options.windowBounds.width,
	height: options.windowBounds.height,
	webPreferences: { 
		//devTools: false,
		nodeIntegration: true,
		contextIsolation: true,
        preload: path.join(__dirname, 'preload.js')
	},
  });
  
  win.webContents.setWindowOpenHandler(({ url }) => {
    shell.openExternal(url);
    return { action: 'deny' };
  });  

  if (options.windowIsMaximized) win.maximize();
  
  win.setMenuBarVisibility(false)  

  // and load the index.html of the app.
  win.loadFile(path.join(__dirname, 'static/nanofl/index.html'));

  // Open the DevTools.
  win.webContents.openDevTools()

  win.on('close', () => saveOptions());
  win.on('closed', () => win = null)
}

let ipcObjects =
{
    process: process,
    dialog: dialog,
    clipboard: clipboard,
};

ipcMain.handle('electronApi:callMethodAsync', (event, objName, methodName, ...args) =>
{
    console.log("electronApi:callMethodAsync", objName, methodName, ...args);
    let obj = ipcObjects[objName];
    let met = obj[methodName];
    return met(...args);
});

ipcMain.on('electronApi:callMethod', (event, objName, methodName, ...args) =>
{
    console.log("electronApi:callMethod", objName, methodName, ...args);
    let obj = ipcObjects[objName];
    let met = obj[methodName];
    event.returnValue = met(...args);
});

ipcMain.on('electronApi:getVar', (event, objName, varName) =>
{
    event.returnValue = ipcObjects[objName][varName];
});

ipcMain.on('electronApi:setVar', (event, objName, varName, value) =>
{
    ipcObjects[objName][varName] = value;
    event.returnValue = null;
});

ipcMain.on('electronApi:getEnvVar', (event, varName) =>
{
    event.returnValue = process.env[varName];
});

ipcMain.on('electronApi:setEnvVar', (event, varName, value) =>
{
    process.env[varName] = value;
    event.returnValue = null;
});

const webServers = {};
ipcMain.on('electronApi:webServerStart', (event, uid, directoryToServe) =>
{
    const child = utilityProcess.fork(path.join(__dirname, 'server.js'), [ directoryToServe ], { stdio:['ignore', 'pipe', 'ignore'] });
    child.on('exit', () => { delete webServers[uid] });
    child.stdout.on('data', data => { webServers[uid].address = (data + "").trim() });
    webServers[uid] = { child:child, address:null };
    event.returnValue = null;
});
ipcMain.on('electronApi:webServerGetAddress', (event, uid) =>
{
    event.returnValue = webServers[uid].address;
});
ipcMain.on('electronApi:webServerKill', (event, uid) =>
{
    if (!webServers[uid]) return;
    try { webServers[uid].child.kill() } catch {}
    delete webServers[uid];
    event.returnValue = null;
});

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', createWindow)

// Quit when all windows are closed.
app.on('window-all-closed', () => {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (win === null) {
    createWindow()
  }
})

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and require them here.

function loadOptions() {
  try {
    options = JSON.parse(fs.readFileSync(path.join(app.getPath("userData"), "config.json"), { encoding: 'utf8' }));
  } catch (err) {
    options = {};
  }
  
  if (!options.windowBounds) options.windowBounds = { x:0, y:0 };
  if (!options.windowBounds.x) options.windowBounds.x = 0;
  if (!options.windowBounds.y) options.windowBounds.y = 0;
  
  let display = screen.getDisplayNearestPoint({ x:options.windowBounds.x, y:options.windowBounds.y });
  if (!(options.windowBounds.x > display.bounds.x && options.windowBounds.x < display.size.width) 
   || !(options.windowBounds.y > display.bounds.y && options.windowBounds.y < display.size.height)) {
    options.windowBounds.x = display.bounds.x
    options.windowBounds.y = display.bounds.y
  }
}

function saveOptions() {
  var newOptions = {
    windowIsMaximized: win.isMaximized(),
    windowBounds: win.isMaximized() ? options.windowBounds : win.getBounds()
  }
  fs.writeFileSync(path.join(app.getPath("userData"), "config.json"), JSON.stringify(newOptions, null, "\t"), { encoding: 'utf8' });
}