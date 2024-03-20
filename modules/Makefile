MODULES = \
	nanofl-ide-globals \
	nanofl-ide-keyboard \
	nanofl-ide-sys \
	nanofl-ide-preloadjs-tools
	
build: 
	@for MODULE in $(MODULES) ;\
	do \
		make -s -C $$MODULE build ;\
	done

clean: 
	@for MODULE in $(MODULES) ;\
	do \
		make -C $$MODULE clean ;\
	done

	
rebuild: clean build
	
.PHONY: build clean rebuild

.SUFFIXES:
