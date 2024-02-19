module.exports = {
    mode: 'development',
    devtool: false,

    target: 'web',

    entry: './bin/resources/app/haxe.js',

    output: {
        library: {
            type: 'assign-properties',
            name: 'window',
        },
        path: __dirname + '/bin/resources/app',
        filename: 'index.js',
    }
}    
