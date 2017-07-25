# this makefile helps test the kaleidoscope-plugin target
# you don't want to copy it to another plugin. Instead. grab 
# build/Makefile.sample

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
BOARD_HARDWARE_PATH ?= $(HOME)/Documents/Arduino/hardware
else
BOARD_HARDWARE_PATH ?= $(HOME)/Arduino/hardware
endif

PLUGIN_TEST_SUPPORT_DIR=$(shell pwd)/tools

include build/rules.mk

