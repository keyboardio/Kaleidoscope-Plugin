TRAVIS_ARDUINO=arduino-1.6.11
TRAVIS_ARDUINO_FILE = $(TRAVIS_ARDUINO)-linux64.tar.xz
EXTRA_BUILDER_ARGS="-libraries ."

all: build-all

# TODO check the shasum of the travis arduino file
travis-install-arduino:
	wget http://downloads.arduino.cc/$(TRAVIS_ARDUINO_FILE)
	tar xf $(TRAVIS_ARDUINO_FILE)

astyle:
	find . -type f -name \*.cpp |xargs -n 1 astyle --style=google
	find . -type f -name \*.ino |xargs -n 1 astyle --style=google
	find . -type f -name \*.h |xargs -n 1 astyle --style=google

travis-test: travis-smoke-examples travis-astyle-check


travis-smoke-examples: travis-install-arduino
	ARDUINO_PATH="$(shell pwd)/$(TRAVIS_ARDUINO)" BOARD_HARDWARE_PATH="$(BOARD_HARDWARE_PATH)" $(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder build-all 

%:	
	$(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder $@


travis-astyle-check: astyle
	$(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope-Plugin/build/astyle-check
