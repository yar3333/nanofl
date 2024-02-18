HAXELIB = nanofl-ide-sys
	
build: node_module/node_modules \
       node_module/index.js

node_module/node_modules: node_module/package.json
	cd node_module && npm i
	mkdir -p node_module/node_modules

node_module/index.js:
	haxe build.hxml
	haxelib dev $(HAXELIB) library
	
clean:
	rm -f  node_module/index.js
	rm -fr library/nanofl
	
rebuild: clean build
	
.PHONY: build clean rebuild

.SUFFIXES: 