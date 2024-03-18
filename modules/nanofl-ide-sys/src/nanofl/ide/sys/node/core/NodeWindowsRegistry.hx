package nanofl.ide.sys.node.core;

import js.lib.Error;
import haxe.io.Path;
import js.html.TextDecoder;
import js.Syntax;
import js.lib.Uint8Array;
import haxe.extern.EitherType;
using StringTools;

typedef ExecSync = (command:String, ?options:js.node.ChildProcess.ChildProcessSpawnSyncOptions) -> EitherType<String, js.node.Buffer>;

class NodeWindowsRegistry
{
    var execSync : ExecSync;

    public function new(execSync:ExecSync)
    {
        this.execSync = execSync;
    }

    /**
        `pathToKey` example: "HKLM:/Software/MyProject".
        Backslashes are also allowed.
    **/
    public function isKeyExists(pathToKey:String)
    {
        pathToKey = prepareRegistryPath(pathToKey);
        return runPowerShell('Test-Path -Path "' + pathToKey.replace("\\", "\\\\") + '"').trim() == "True";
    }

    /**
        `path` is path to key (if you want to get default value) or value.
        Example: "HKLM:/Software/MyProject/MyRegistryKey".
        Backslashes are also allowed.
        Returns `null` on key/value not exists.
    **/
    public function getValue(path:String) : String
    {
        if (isKeyExists(path)) return getValueInner(path + "/(default)");
        if (!isKeyExists(Path.directory(path))) return null;
        return getValueInner(path);
    }

    function getValueInner(pathToValue:String) : String
    {
        pathToValue = prepareRegistryPath(pathToValue);

        var n = pathToValue.lastIndexOf("\\");
        var keyPath = pathToValue.substr(0, n).replace("\\", "\\\\"); // escape "\" for using in script
        var keyName = pathToValue.substr(n + 1);

        var r = runPowerShell("
            $ErrorActionPreference = 'Stop'
            $keyPath = \"" + keyPath + "\"
            $key = \"" + keyName + "\"
    
            try {
                $value = Get-ItemProperty -Path $keyPath -Name $key
                if ($value -ne $null) {
                    Write-Output $value.$key
                } else {
                    Write-Output \"---NOT_FOUND\"
                }
            } catch {
                Write-Output \"---ERROR: $_\"
            }
        ").trim();
        
        if (r == "---NOT_FOUND") return null;        
        
        if (r.startsWith("---ERROR:"))
        {
            throw new Error(r.substring("---ERROR:".length).trim());
        }

        return r;
    }

    private function runPowerShell(script:String) : String
    {
        return bufferToString(execSync(script, { shell: 'powershell.exe' }));
    }

    private static function prepareRegistryPath(keyPath:String) : String
    {
        keyPath = keyPath.replace("/", "\\");

        if      (keyPath.startsWith("HKCC:")) return "Registry::HKEY_CURRENT_CONFIG" + keyPath.substring("HKCC:".length);
        else if (keyPath.startsWith("HKCR:")) return "Registry::HKEY_CLASSES_ROOT"   + keyPath.substring("HKCR:".length);
        else if (keyPath.startsWith("HKCU:")) return "Registry::HKEY_CURRENT_USER"   + keyPath.substring("HKCU:".length);
        else if (keyPath.startsWith("HKLM:")) return "Registry::HKEY_LOCAL_MACHINE"  + keyPath.substring("HKLM:".length);
        else if (keyPath.startsWith("HKU:"))  return "Registry::HKEY_USERS"          + keyPath.substring("HKU:" .length);
        
        return keyPath;
    }

    private static function bufferToString(buffer:Uint8Array) : String
    {
        if (Syntax.typeof(buffer) == "string") return cast buffer;
        return new TextDecoder().decode(buffer);
    }
}