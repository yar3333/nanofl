CSS_FILES =	src/components/nanofl/movie/timeline/template.css \
		    src/components/nanofl/movie/timelinelayer/template.css \
			src/components/nanofl/others/mainmenu/template.css \
			src/components/nanofl/others/properties/template.css \
			src/components/nanofl/popups/basepopup/template.css

build: node_modules \
	   bin/templates/scripts/three-r161.js \
	   $(CSS_FILES) \
       engine \
       bin/plugins \
       bin/resources/app/static
	
	make -s -C ../modules

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
	
%.css: %.less
	npx lessc -s $^ $@

##############################################################################################

PHONY: rebuild build clean run

.SUFFIXES:
