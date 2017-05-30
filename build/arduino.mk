TRAVIS_ARDUINO=arduino-1.6.11
TRAVIS_ARDUINO_FILE = $(TRAVIS_ARDUINO)-linux64.tar.xz
TRAVIS_ARDUINO_PATH ?= $(shell pwd)/$(TRAVIS_ARDUINO)

travis-install-arduino:
	if [! -d "$(TRAVIS_ARDUINO_PATH)" ]; then \
		wget http://downloads.arduino.cc/$(TRAVIS_ARDUINO_FILE); \
       		tar xf $(TRAVIS_ARDUINO_FILE); \
	fi
