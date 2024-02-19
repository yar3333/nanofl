PROJECTS =	alpha \
			bitmapfill \
			blur \
			button \
			coloreffects \
			curve \
			curvefill \
			drawingobject \
			earth \
			emptyclips \
			filters \
			font \
			group \
			guide \
			guidespeed \
			likebutton \
			linearfill \
			lines \
			mask \
			maskfilter \
			mirror \
			nestedit \
			radialfill \
			shape \
			solidfill \
			text \
			textmask \
			textureatlas \
			transform \
			tween \
			WaterLogic-haxe \
			zindex

DST_LIST = $(addsuffix .release,$(PROJECTS))

build: $(DST_LIST)

rebuild: clean build

clean:
	@for DST in $(DST_LIST) ;\
	do \
		rm -rf $$DST/library ;\
		rm -rf $$DST/scripts ;\
		rm -f $$DST/src/nanofl-code.ts ;\
		rm -f $$DST/library.js ;\
		rm -f $$DST/index.html ;\
	done

%.release:
	if [ -f $(basename $@)/$(basename $@).nfl ]; then \
		../ide/bin/nanofl.exe $(basename $@)/$(basename $@).nfl -publish -quit ;\
	fi
	
	#if [ -f $(basename $@)/$(basename $@).xfl ]; then \
	#	../ide/nanofl.exe $(basename $@)/$(basename $@).xfl -publish -quit ;\
	#fi
