EXTRA_BUILDER_ARGS="-libraries ."

all: build-all


astyle:
	find . -type f -name \*.cpp |xargs -n 1 astyle --style=google
	find . -type f -name \*.ino |xargs -n 1 astyle --style=google
	find . -type f -name \*.h |xargs -n 1 astyle --style=google

	
%:	
	$(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder $@
