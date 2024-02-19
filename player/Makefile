VERSION := $(shell cat ../engine/nanofl/engine/Version.hx | grep player | grep -o '[0-9]\+[.][0-9]\+[.][0-9]\+')

DEST_JS := ../ide/bin/templates/scripts/nanofl-$(VERSION).js

build: node_modules ../plugins/bin/filters/StdFiltersPlugin.js engine
	haxe build.hxml
	npx webpack
	echo "window.THREE = window.THREE || {};" > $(DEST_JS)
	echo "window.THREE_addons_GLTFLoader = window.THREE_addons_GLTFLoader || {};" >> $(DEST_JS)
	echo "" >> $(DEST_JS)
	cat bin/nanofl-bundle.js >> $(DEST_JS)
	cat ../plugins/bin/filters/StdFiltersPlugin.js >> $(DEST_JS)

engine:
	npx symlink-dir ../engine engine

../plugins/bin/filters/StdFiltersPlugin.js:
	make -C ../plugins
	
node_modules:
	npm i

PHONY: build

.SUFFIXES:
