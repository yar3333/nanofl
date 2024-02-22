const { contextBridge, ipcRenderer } = require('electron/renderer');
const fs = require('fs');
const { Buffer } = require('node:buffer');
const child_process = require('child_process');
const { http_utils, process_utils } = require('./preloadjs-tools.js');

contextBridge.exposeInMainWorld('electronApi',
{
    callMethodAsync: (objName, methodName, ...args) =>
    {
        return ipcRenderer.invoke('electronApi:callMethodAsync', objName, methodName, ...args);
    },
    
    callMethod: (objName, methodName, ...args) =>
    {
        return ipcRenderer.sendSync('electronApi:callMethod', objName, methodName, ...args);
    },
    
    getVar: (objName, varName) =>
    {
        return ipcRenderer.sendSync('electronApi:getVar', objName, varName);
    },
    
    setVar: (objName, varName, value) =>
    {
        ipcRenderer.sendSync('electronApi:setVar', objName, varName, value);
    },
    
    getEnvVar: (varName) =>
    {
        return ipcRenderer.sendSync('electronApi:getEnvVar', varName);
    },
    
    setEnvVar: (varName, value) =>
    {
        ipcRenderer.sendSync('electronApi:setEnvVar', varName, value);
    },

    fs: fs,
    createBuffer: Buffer.from,
    child_process: child_process,
    http_utils: http_utils,
    process_utils: process_utils,
});
