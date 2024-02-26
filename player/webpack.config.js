/** @type {import('webpack').Configuration} */
module.exports = {
    mode: 'production',
    optimization: {
        minimize: false,
    },

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
		"three": "THREE",
        "three/addons/loaders/GLTFLoader.js" : "THREE_addons_GLTFLoader",
	},

    performance: {
        maxEntrypointSize: 512000,
        maxAssetSize: 512000
    }    
}    
