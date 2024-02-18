build: node_modules
	npm run build
	cp dist/preloadjs-tools.js ../../ide/bin/resources/app/preloadjs-tools.js
	
clean:
	rm -fr  dist
	
rebuild: clean build

node_modules:
	npm i
	
.PHONY: build clean rebuild

.SUFFIXES: 