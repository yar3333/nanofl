PLUGINS = $(wildcard filters/*) $(wildcard loaders/*) $(wildcard importers/*) $(wildcard exporters/*)
JS_RESULTS = $(addprefix bin/,$(addsuffix .js,$(PLUGINS)))

rebuild: clean build

build: api $(JS_RESULTS)

bin/%.js:
	haxe --cwd $* build.hxml

clean:
	rm -rf bin/*

api:
	make -C api

.PHONY: build rebuild clean api
.SUFFIXES: 