package nanofl.ide.sys.node.core;

import haxe.extern.EitherType;
import js.lib.Error;
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
        `fullKey` example: "HKLM:/Software/MyProject/MyRegistryKey"
    **/
    public function getKeyValue(fullKey:String) : String
    {
        fullKey = fullKey.replace("/", "\\");

        var n = fullKey.lastIndexOf("\\");
        var keyPath = fullKey.substr(0, n).replace("\\", "\\\\");
        var keyName = fullKey.substr(n + 1);

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
        ").toString();

        return r;
    }

    private function runPowerShell(script:String) : String
    {
        var r = execSync(script, { shell: 'powershell.exe' });
        if (!Std.isOfType(r, String)) r = (cast r : js.node.Buffer).toString();
        if (r == "---NOT_FOUND") return null;
        if (r.startsWith("---ERROR:")) throw new Error(r);
        return r;
    }
}