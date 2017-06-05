# this makefile helps test the kaleidoscope-plugin target
# you don't want to copy it to another plugin. Instead. grab 
# build/Makefile.sample

UNAME_S := $(shell uname -s)

BOARD_HARDWARE_PATH ?= $(HOME)/Arduino/hardware
ifeq ($(UNAME_S),Darwin)
	BOARD_HARDWARE_PATH ?= $(HOME)/Library/Arduino/hardware
endif

PLUGIN_TEST_SUPPORT_DIR=$(shell pwd)/tools

include build/*.mk
