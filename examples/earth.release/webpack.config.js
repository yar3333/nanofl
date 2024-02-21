module.exports = {
	mode: 'development',
    
    entry: './src/application.ts',
    
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
        library: {
            type: 'assign-properties',
            name: 'window',
        },
        filename: 'application.js',
        path: __dirname + "/scripts",
    },

	externals: {
		"three": "THREE",
        "three/addons/loaders/GLTFLoader.js" : "THREE_addons_GLTFLoader",
	}
};