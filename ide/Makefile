build: node_modules \
	   bin/templates/scripts/three-r161.js \
       engine \
       bin/plugins \
       bin/resources/app/static
	
	make -C ../modules

	haxe build.hxml --main Main -D no-trial -D long-asserts
	
	npx webpack
	rm bin/resources/app/haxe.js
	
	npx cpx -u "src/components/**/support/**" bin/resources/app/components

rebuild: clean build

clean:
	if [ -d bin/resources/app ]; then \
		/bin/find bin/resources/app -mindepth 1 \
			-not -path "bin/resources/app/package.json" \
			-not -path "bin/resources/app/main.js" \
			-not -path "bin/resources/app/preload.js" \
			-not -path "bin/resources/app/static*" \
			-not -path "bin/resources/app/tools*" \
			-not -path "bin/resources/app/preferences*" \
			-not -path "bin/resources/app/templates*" \
			-not -path "bin/resources/app/node_modules*" \
			-delete ;\
	fi
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
