

EXTRA_BUILDER_ARGS="-libraries ."
PLUGIN_TEST_SUPPORT_DIR ?= $(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope-Plugin/build/
PLUGIN_TEST_BIN_DIR ?= $(PLUGIN_TEST_SUPPORT_DIR)/$(shell arch)/bin

# TODO check the shasum of the travis arduino file

.PHONY: travis-install-arduino astyle travis-test travis-astyle-check travis-smoke-examples

all: build-all

astyle:	
	$(PLUGIN_TEST_SUPPORT_DIR)/run-astyle

travis-test: travis-smoke-examples travis-astyle-check


travis-smoke-examples: travis-install-arduino
	ARDUINO_PATH="$(TRAVIS_ARDUINO_PATH)" BOARD_HARDWARE_PATH="$(BOARD_HARDWARE_PATH)" $(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder build-all 


travis-astyle-check:
	export PATH=$(PLUGIN_TEST_BIN_DIR):$(PATH) 
	$(PLUGIN_TEST_SUPPORT_DIR)/run-astyle
	$(PLUGIN_TEST_SUPPORT_DIR)/astyle-check

%:	
	$(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder $@
