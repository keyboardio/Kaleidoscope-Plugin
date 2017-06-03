

EXTRA_BUILDER_ARGS="-libraries ."
PLUGIN_TEST_SUPPORT_DIR ?= $(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope-Plugin/build/
PLUGIN_TEST_BIN_DIR ?= $(PLUGIN_TEST_SUPPORT_DIR)/$(shell arch)/bin

# TODO check the shasum of the travis arduino file

.PHONY: travis-install-arduino astyle travis-test travis-check-astyle travis-smoke-examples test

all: build-all
	@: ## Do not remove this line, otherwise `make all` will trigger the `%` rule too.

astyle:	
	$(PLUGIN_TEST_SUPPORT_DIR)/run-astyle

travis-test: travis-smoke-examples travis-check-astyle

test: smoke-examples check-astyle

smoke-examples:
	$(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder build-all 

check-astyle:
	$(PLUGIN_TEST_SUPPORT_DIR)/run-astyle
	$(PLUGIN_TEST_SUPPORT_DIR)/astyle-check
	
cpplint-noisy:
	$(PLUGIN_TEST_SUPPORT_DIR)/cpplint.py  --filter=-legal/copyright,-build/include,-readability/namespace,-whitespace/line_length  --recursive --extensions=cpp,h,ino --exclude=$(BOARD_HARDWARE_PATH) --exclude=$(TRAVIS_ARDUINO_PATH) .

cpplint:
	$(PLUGIN_TEST_SUPPORT_DIR)/cpplint.py  --filter=-whitespace,-legal/copyright,-build/include,-readability/namespace  --recursive --extensions=cpp,h,ino --exclude=$(BOARD_HARDWARE_PATH) --exclude=$(TRAVIS_ARDUINO_PATH) .

travis-smoke-examples: travis-install-arduino
	ARDUINO_PATH="$(TRAVIS_ARDUINO_PATH)" BOARD_HARDWARE_PATH="$(BOARD_HARDWARE_PATH)" $(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder build-all 


travis-check-astyle:
	PATH=$(PLUGIN_TEST_BIN_DIR):$(PATH) $(PLUGIN_TEST_SUPPORT_DIR)/run-astyle
	$(PLUGIN_TEST_SUPPORT_DIR)/astyle-check

%:	
	$(BOARD_HARDWARE_PATH)/keyboardio/avr/libraries/Kaleidoscope/tools/kaleidoscope-builder $@
