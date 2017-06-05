TRAVIS_ARDUINO=arduino-1.8.2
TRAVIS_ARDUINO_FILE = $(TRAVIS_ARDUINO)-linux64.tar.xz
TRAVIS_ARDUINO_PATH ?= $(shell pwd)/$(TRAVIS_ARDUINO)
TRAVIS_ARDUINO_DOWNLOAD_URL = http://downloads.arduino.cc/$(TRAVIS_ARDUINO_FILE)

travis-install-arduino:
	@if [ ! -d "$(TRAVIS_ARDUINO_PATH)" ]; then \
		echo "Installing Arduino..."; \
		wget -O "$(TRAVIS_ARDUINO_FILE)" -c $(TRAVIS_ARDUINO_DOWNLOAD_URL); \
		tar xf $(TRAVIS_ARDUINO_FILE); \
	fi
