const http = require("http");
const fs = require('fs');
const process = require("process");
const path = require("path");

const baseDir = process.argv[2];
if (!baseDir)
{
    console.error("Specify argument: directory to serve.");
    process.exit(1);
}

const server =  http.createServer((request, response) =>
{
    console.error("Url:", request.url);
    console.error("Method:", request.method);
    console.error("User-Agent:", request.headers["user-agent"]);
    console.error("Headers");
    console.error(request.headers);

    if (request.method != "GET") { response.statusCode = 405; end("Only GET method is supported.");  return; }

    const filePath = path.join(baseDir, decodeURI(request.url));
    if (!request.url || request.url == "/" || !fs.existsSync(filePath)) { response.statusCode = 404; response.end("File not found.");  return; }

    const stat = fs.statSync(filePath)
    if (!stat.isFile()) { response.statusCode = 400; response.end("Only files are supported.");  return; }

    response.setHeader("Content-Type", getMimeType(filePath));
    response.setHeader("Content-Length", stat.size);
    response.setHeader("Cache-Control", "max-age=0, no-cache");

    response.write(fs.readFileSync(filePath), () => { response.end() });
});

server.listen(0, "127.0.0.1", () =>
{
    console.log("http://" + server.address().address + ":" + server.address().port);
});

function getMimeType(filePath)
{
    switch (path.extname(filePath).toLowerCase())
    {
        case ".htm": return "text/html";
        case ".html": return "text/html";
        case ".css": return "text/css";
        case ".js": return "text/javascript";
        case ".mjs": return "text/javascript";
        case ".txt": return "text/plain";
        case ".csv": return "text/csv";
        case ".ico": return "image/vnd.microsoft.icon";
        
        case ".json": return "application/json";
        case ".xml": return "application/xml";
        
        case ".gz": return "application/gzip";
        case ".zip": return "application/zip";
        case ".bz": return "application/x-bzip";
        case ".bz2": return "application/x-bzip2";
        case ".7z": return "application/x-7z-compressed";
        
        case ".jpg": return "image/jpeg";
        case ".jpeg": return "image/jpeg";
        case ".gif": return "image/gif";
        case ".png": return "image/png";
        case ".bmp": return "image/bmp";
        case ".tif": return "image/tiff";
        case ".tiff": return "image/tiff";

        case ".mp4": return "video/mp4";
        case ".mpeg": return "video/mpeg";
        case ".webm": return "video/webm";
        case ".weba": return "audio/webm";
        case ".webp": return "image/webp";

        case ".wav": return "audio/wav";
        case ".mp3": return "audio/mpeg";
        
        case ".ogg": return "audio/ogg";
        case ".oga": return "audio/ogg";
        case ".ogv": return "video/ogg";
        case ".ogx": return "application/ogg";

        case ".woff": return "font/woff";
        case ".woff2": return "font/woff2";
    }

    return "application/octet-stream";
}
