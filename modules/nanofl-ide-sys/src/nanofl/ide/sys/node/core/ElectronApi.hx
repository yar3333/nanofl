package nanofl.ide.sys.node.core;

import js.lib.ArrayBuffer;
import js.lib.Function;
import js.Browser;

class ElectronApi
{
    public static var fs(get, never) : NodeFs;
    static inline function get_fs() return (cast Browser.window).electronApi.fs;
    
    public static var child_process(get, never) : NodeChildProcess;
    static inline function get_child_process() return (cast Browser.window).electronApi.child_process;
    
    public static var http_utils(get, never) : HttpUtils;
    static inline function get_http_utils() return (cast Browser.window).electronApi.http_utils;
    
    public static var process_utils(get, never) : ProcessUtils;
    static inline function get_process_utils() return (cast Browser.window).electronApi.process_utils;
    
    public static function callMethodAsync<T>(objName:String, methodName:String, ...args:Dynamic) : js.lib.Promise<T>
    {
        var argsArray = (cast [ objName, methodName ] : Array<Dynamic>).concat(args.toArray());
        return (cast (cast Browser.window).electronApi.callMethodAsync : js.lib.Function).apply(null, argsArray);
    }

    public static function callMethod(objName:String, methodName:String, ...args:Dynamic) : Dynamic
    {
        var argsArray = (cast [ objName, methodName ] : Array<Dynamic>).concat(args.toArray());
        return (cast (cast Browser.window).electronApi.callMethod : js.lib.Function).apply(null, argsArray);
    }

    public static function getVar(objName:String, varName:String) : Dynamic
    {
        return (cast Browser.window).electronApi.getVar(objName, varName);
    }

    public static function setVar(objName:String, varName:String, value:Dynamic) : Void
    {
        (cast Browser.window).electronApi.setVar(objName, varName, value);
    }

    public static function getEnvVar(varName:String) : String
    {
        return (cast Browser.window).electronApi.getEnvVar(varName.toUpperCase());
    }

    public static function setEnvVar(varName:String, value:String) : Void
    {
        (cast Browser.window).electronApi.setEnvVar(varName.toUpperCase(), value);
    }

    public static function createBuffer(data:ArrayBuffer, byteOffset:Int, length:Int) : NodeBuffer
    {
        return (cast Browser.window).electronApi.createBuffer(data, byteOffset, length);
    }
}
