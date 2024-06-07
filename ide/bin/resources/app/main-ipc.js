const { ipcMain, dialog, clipboard, utilityProcess } = require('electron/main');
const path = require('path');

function ipcInit()
{
    const ipcObjects =
    {
        process: process,
        dialog: dialog,
        clipboard: clipboard,
    };

    ipcMain.handle('electronApi:callMethodAsync', (event, objName, methodName, ...args) =>
    {
        console.log("electronApi:callMethodAsync", objName, methodName, ...args);
        const obj = ipcObjects[objName];
        const met = obj[methodName];
        return met(...args);
    });

    ipcMain.on('electronApi:callMethod', (event, objName, methodName, ...args) =>
    {
        console.log("electronApi:callMethod", objName, methodName, ...args);
        const obj = ipcObjects[objName];
        const met = obj[methodName];
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
}

module.exports =
{ 
    ipcInit,
};
