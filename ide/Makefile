build: node_modules \
	   bin/templates/scripts/three-r161.js \
       engine \
       bin/plugins \
       bin/resources/app/static
	
	make -C ../modules

	haxe build.hxml --main Main -D long-asserts
	
	npx webpack
	rm bin/resources/app/haxe.js
	
	npx cpx -u "src/components/**/support/**" bin/resources/app/components

rebuild: clean build

clean:
	rm -f  bin/resources/app/index.js
	rm -rf bin/resources/app/components
	make -C ../modules clean

run:
	cd bin && NanoFL.exe
	
node_modules:
	npm install
	
bin/templates/scripts/three-r161.js:
	mkdir -p $(@D)
	cp node_modules/three/build/three.module.js $@

engine:
	npx symlink-dir ../engine $@

bin/plugins:
	npx symlink-dir ../plugins/bin $@

bin/resources/app/static:
	npx symlink-dir static $@

##############################################################################################

PHONY: rebuild build clean run

.SUFFIXES:
