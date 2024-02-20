build: ide plugins player

ide:
	@echo ide =================================================================
	make -C ide rebuild
	@echo

plugins:
	@echo plugins =============================================================
	make -C plugins
	@echo

player:
	@echo player ==============================================================
	make -C player build
	@echo

examples:
	make -C examples
	
installer:
	make -C installer

.PHONY: build ide plugins player examples installer
