VERSION := $(shell cat ../engine/nanofl/engine/Version.hx | grep ide | grep -o "[0-9]\+[.][0-9]\+[.][0-9]\+")

DEST_WINDOWS := bin/nanofl-$(VERSION).exe
DEST_LINUX := bin/nanofl-$(VERSION).zip

SRC := ../ide/bin

DEPS = $(wildcard ../ide/bin/**/*) $(wildcard ../examples/**/*)  $(wildcard ../plugins/bin/**/*)

build: $(DEST_WINDOWS)
$(DEST_WINDOWS): license_*.rtf nanofl.iss $(DEPS)
	@echo installer ===========================================================
	"c:\Program Files (x86)\Inno Setup 5\iscc" -qp -dVERSION=$(VERSION) nanofl.iss

.PHONY: build
