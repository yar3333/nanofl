import { SpawnOptions, spawn  } from 'child_process';

type ProcessResult = 
{
    code : number | null,
    out : string,
    err : string,
}

export namespace process_utils
{
    export function runPipedStdIn(filePath:string, args:Array<string>, directory:string, env:{[name:string]: string}, getDataForStdIn:()=>Promise<ArrayBuffer>) : Promise<ProcessResult>
    {
        var options : SpawnOptions = { stdio: "pipe" };
        if (directory != null) options.cwd = directory;
        if (env != null) options.env = env;
        
        var process = spawn(filePath, args, options);

        return new Promise<ProcessResult>((resolve, reject) =>
        {
            var outStr = "";
            var errStr = "";

            if (!process.stdout) { reject("process.stdout is null"); return; }
            if (!process.stderr) { reject("process.stderr is null"); return; }
    
            process.stdout.on('data', data =>
            {
                outStr += data;
            });
                
            process.stderr.on('data', data =>
            {
                errStr += data;
            });
                
            process.on('close', code =>
            {
                resolve({ code:code, out:outStr, err:errStr });
            });         
            
            process.on('error', code =>
            {
                reject({ code:code, out:outStr, err:errStr });
            });

            function sendNextChunk()
            {
                getDataForStdIn().then(data =>
                {
                    if (!process.stdin) { reject("process.stdin is null"); return; }
                    
                    if (data == null) { process.stdin.end(); return; }
                    
                    if (!process.stdin.write(Buffer.from(data)))
                        process.stdin.once("drain", () => sendNextChunk());
                    else
                        setTimeout(() => sendNextChunk(), 1);
                });
            }

            sendNextChunk();
        });
    }
}
