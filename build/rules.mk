TRAVIS_ARDUINO=arduino-1.6.11
TRAVIS_ARDUINO_FILE = $(TRAVIS_ARDUINO)-linux64.tar.xz
EXTRA_BUILDER_ARGS="-libraries ."

all: build-all

travis-install-arduino:
	wget http://downloads.arduino.cc/$(TRAVIS_ARDUINO_FILE)
	tar xf $(TRAVIS_ARDUINO_FILE)
	ln -s $(TRAVIS_ARDUINO) arduino

astyle:
	find . -type f -name \*.cpp |xargs -n 1 astyle --style=google
	find . -type f -name \*.ino |xargs -n 1 astyle --style=google
	find . -type f -name \*.h |xargs -n 1 astyle --style=google

	
%:	
	$(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder $@
