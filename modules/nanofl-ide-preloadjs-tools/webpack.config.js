/** @type {import('@types/webpack').Configuration} */

module.exports = {
    target: 'electron-preload',
	mode: 'development',
    devtool: false,
    entry: './src/main.ts',
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: 'ts-loader',
                exclude: /node_modules/,
            },
        ],
    },
    resolve: {
        extensions: ['.tsx', '.ts', '.js'],
    },
    output: {
        asyncChunks: false, // force one file on output
        library: {
            type: 'commonjs'
        },
        filename: 'preloadjs-tools.js',
        path: __dirname + '/dist',
    }
};