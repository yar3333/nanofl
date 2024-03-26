VERSION := $(shell cat ../engine/nanofl/engine/Version.hx | grep ide | grep -o "[0-9]\+[.][0-9]\+[.][0-9]\+")

DEST_WINDOWS := bin/nanofl-win64-$(VERSION).exe

build: $(DEST_WINDOWS)

$(DEST_WINDOWS):
	@echo installer ===========================================================
	"c:\Program Files (x86)\Inno Setup 6\iscc" -qp -dVERSION=$(VERSION) nanofl.iss

.PHONY: build
