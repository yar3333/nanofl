VERSION := $(shell cat ../engine/nanofl/engine/Version.hx | grep ide | grep -o "[0-9]\+[.][0-9]\+[.][0-9]\+")

DEST_WINDOWS_INSTALLER := bin/nanofl-win64-$(VERSION).exe
DEST_WINDOWS_ZIP := bin/nanofl-win64-$(VERSION).zip

build: $(DEST_WINDOWS_INSTALLER) \
       $(DEST_WINDOWS_ZIP)

$(DEST_WINDOWS_INSTALLER):
	@echo installer ===========================================================
	"c:\Program Files (x86)\Inno Setup 6\iscc" -qp -dVERSION=$(VERSION) nanofl.iss
	
$(DEST_WINDOWS_ZIP):
	@echo zip =================================================================
	7z a -tzip $(DEST_WINDOWS_ZIP) ..\ide\bin
	7z rn $(DEST_WINDOWS_ZIP) bin nanofl-$(VERSION)

.PHONY: build
