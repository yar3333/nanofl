module.exports = {
    mode: 'development',
    devtool: false,

	target: "web",
	
    entry: './bin/nanofl-haxe.js',
    
    resolve: {
        alias: {
            three: __dirname + '/node_modules/three'
        }
    },	
	
    output: {
        library: {
            type: 'assign-properties',
            name: 'window',
        },
        path: __dirname + '/bin',
        filename: 'nanofl-bundle.js',

    },

	externals: {
		"jquery": "jQuery",
		"three": "three",
        "three/addons/loaders/GLTFLoader.js" : "three_GLTFLoader",
	}
}    
