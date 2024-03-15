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
    
            process.stdout.on('data', (data:Buffer) =>
            {
                outStr += data.toString();
            });
                
            process.stderr.on('data', (data:Buffer) =>
            {
                errStr += data.toString();
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
                    
                    if (process.stdin.write(Buffer.from(data)))
                    {
                        setTimeout(() => sendNextChunk(), 1);
                    }
                });
            }
            
            if (!process.stdin) { reject("process.stdin is null"); return; }
            process.stdin.on("drain", () => sendNextChunk());

            sendNextChunk();
        });
    }

    export function runPipedStdOut(filePath:string, args:Array<string>, directory:string, env:{[name:string]: string}, input:string, chunkSize:number, processChunk:(chunk:Uint8Array)=>void) : Promise<ProcessResult>
    {
		var options : SpawnOptions = {};
		if (directory != null) options.cwd = directory;
		if (env != null) options.env = env;
		
		const process = spawn(filePath, args, options);

        const buffer = chunkSize >= 0 ? new Uint8Array(chunkSize) : null;
        var pBuffer = 0;
		
        return new Promise<ProcessResult>((resolve, reject) =>
        {
            var errStr = "";

            if (process.stdout == null) { reject("process.stdout is null"); return; }
            if (process.stderr == null) { reject("process.stderr is null"); return; }
    
            process.stdout.on('data', (data:Buffer) =>
            {
                if (buffer == null) { processChunk(data); return; }

                var pData = 0;
                while (pData < data.byteLength)
                {
                    const bytesToCopy = Math.min(data.byteLength - pData, buffer.byteLength - pBuffer);
                    data.copy(buffer, pBuffer, pData, pData + bytesToCopy);
                    pBuffer += bytesToCopy;
                    pData += bytesToCopy;
                    if (pBuffer == buffer.byteLength)
                    {
                        processChunk(buffer);
                        pBuffer = 0;
                    }
                }
            });
                
            process.stderr.on('data', (data:Buffer) =>
            {
                errStr += data.toString();
            });
                
            process.on('close', code =>
            {
                resolve({ code:code, out:"", err:errStr });
            });         
            
            process.on('error', code =>
            {
                reject({ code:code, out:"", err:errStr });
            });

            if (process.stdin == null) { reject("process.stdin is null"); return; }

       		if (input != null) process.stdin.write(input);
        });
    }    
}
