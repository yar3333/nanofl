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

DST = $(addsuffix .release,$(PROJECTS))

build: $(DST)

rebuild: clean build

clean:
	rm -rf $(DST)

%.release:
	if [ -f $(basename $@)/$(basename $@).nfl ]; then \
		../ide/bin/nanofl.exe $(basename $@)/$(basename $@).nfl -publish -quit ;\
	fi
	
	#if [ -f $(basename $@)/$(basename $@).xfl ]; then \
	#	../ide/nanofl.exe $(basename $@)/$(basename $@).xfl -publish -quit ;\
	#fi
