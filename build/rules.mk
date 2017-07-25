EXTRA_BUILDER_ARGS="-libraries ."
PLUGIN_TEST_SUPPORT_DIR ?= $(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope-Plugin/tools/
PLUGIN_TEST_BIN_DIR ?= $(PLUGIN_TEST_SUPPORT_DIR)/$(shell arch)/bin

TRAVIS_ARDUINO=arduino-1.8.2
TRAVIS_ARDUINO_FILE = $(TRAVIS_ARDUINO)-linux64.tar.xz
TRAVIS_ARDUINO_PATH ?= $(shell pwd)/$(TRAVIS_ARDUINO)
TRAVIS_ARDUINO_DOWNLOAD_URL = http://downloads.arduino.cc/$(TRAVIS_ARDUINO_FILE)

# TODO check the shasum of the travis arduino file

.PHONY: travis-install-arduino astyle travis-test travis-check-astyle travis-smoke-examples test cpplint cpplint-noisy

.DEFAULT_GOAL := all

all: build-all
	@: ## Do not remove this line, otherwise `make all` will trigger the `%` rule too.

astyle:	
	$(PLUGIN_TEST_SUPPORT_DIR)/run-astyle

travis-test: travis-smoke-examples travis-check-astyle

test: smoke-examples check-astyle cpplint-noisy

smoke-examples:
	$(PLUGIN_TEST_SUPPORT_DIR)/kaleidoscope-builder build-all 

check-astyle:
	$(PLUGIN_TEST_SUPPORT_DIR)/run-astyle
	$(PLUGIN_TEST_SUPPORT_DIR)/astyle-check
	
cpplint-noisy:
	$(PLUGIN_TEST_SUPPORT_DIR)/cpplint.py  --filter=-legal/copyright,-build/include,-readability/namespace,,-whitespace/line_length  --recursive --extensions=cpp,h,ino --exclude=$(BOARD_HARDWARE_PATH) --exclude=$(TRAVIS_ARDUINO) src examples


cpplint:
	$(PLUGIN_TEST_SUPPORT_DIR)/cpplint.py  --quiet --filter=-whitespace,-legal/copyright,-build/include,-readability/namespace  --recursive --extensions=cpp,h,ino src examples

travis-smoke-examples: travis-install-arduino
	ARDUINO_PATH="$(TRAVIS_ARDUINO_PATH)" BOARD_HARDWARE_PATH="$(BOARD_HARDWARE_PATH)" $(PLUGIN_TEST_SUPPORT_DIR)/kaleidoscope-builder build-all


travis-check-astyle:
	PATH=$(PLUGIN_TEST_BIN_DIR):$(PATH) $(PLUGIN_TEST_SUPPORT_DIR)/run-astyle
	$(PLUGIN_TEST_SUPPORT_DIR)/astyle-check

%:	
	$(PLUGIN_TEST_SUPPORT_DIR)/kaleidoscope-builder $@


travis-install-arduino:
	@if [ ! -d "$(TRAVIS_ARDUINO_PATH)" ]; then \
		echo "Installing Arduino..."; \
		wget -O "$(TRAVIS_ARDUINO_FILE)" -c $(TRAVIS_ARDUINO_DOWNLOAD_URL); \
		tar xf $(TRAVIS_ARDUINO_FILE); \
	fi
