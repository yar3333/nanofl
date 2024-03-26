DEST=../../ide/bin/resources/app/preloadjs-tools.js

build: $(DEST)
	
$(DEST): node_modules
	npm run build
	cp dist/preloadjs-tools.js $(DEST)
	
clean:
	rm -fr  dist
	rm -f $(DEST)
	
rebuild: clean build

node_modules:
	npm i
	
.PHONY: build clean rebuild

.SUFFIXES: 