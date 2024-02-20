build: ide api plugins player

ide: FORCE
	@echo ide =================================================================
	make -C ide rebuild
	@echo

api: FORCE
	@echo api =================================================================
	make -C api build
	@echo

plugins: FORCE
	@echo plugins =============================================================
	make -C plugins
	@echo

player: FORCE
	@echo player ==============================================================
	make -C player build
	@echo

examples: FORCE
	make -C examples

WaterLogic: FORCE
	make -C examples WaterLogic
	
installer: FORCE
	make -C installer

FORCE:
