import fetch, { RequestInit, Response, FormData, File, fileFrom } from 'node-fetch';
import * as path from 'path';
import * as fs from 'fs';

export namespace http_utils
{
    export function requestGet(url:string, headers?:Array<{ name:string, value:string }>) : Promise<{ statusCode:Number, arrayBuffer:ArrayBuffer }>
    {
        let gResponse: Response;
        return fetch(new URL(url), { method:"GET", headers:headers?.map(x => [ x.name, x.value ]) })
                .then(response =>
                {
                    gResponse = response;
                    return response.blob();
                })
                .then(blob => blob.arrayBuffer())
                .then(arrayBuffer => ({ statusCode:gResponse.status, arrayBuffer:arrayBuffer }));
    }
	
    export function requestPost(url:string, headers?:Array<{ name:string, value:string }>, fields?:Array<{ name:string, value:string }>, files?:Array<{ name:string, path:string }>) : Promise<{ statusCode:Number, arrayBuffer:ArrayBuffer }>
	{
        let gResponse: Response;

        const formData = new FormData();
        if (fields)
        {
            for (const f of fields) formData.set(f.name, f.value);
        }
        if (files)
        {
            for (const f of files) formData.set(f.name, new File([ fs.readFileSync(f.path) ], path.basename(f.path)));
        }

        const requestInit: RequestInit =
        {
            method: "POST", 
            headers: headers?.map(x => [ x.name, x.value ]),
            body: formData
        };

        return fetch(new URL(url), requestInit)
                .then(response =>
                {
                    gResponse = response;
                    return response.blob();
                })
                .then(blob => blob.arrayBuffer())
                .then(arrayBuffer => ({ statusCode:gResponse.status, arrayBuffer:arrayBuffer }));
    }

    export function downloadFile(url:string, destFilePath:string, progress?:(percent:number)=>void) : Promise<boolean>
    {
        return requestGet(url)
            .then(result => { fs.writeFileSync(destFilePath, new DataView(result.arrayBuffer)); return true; });
    }
}
