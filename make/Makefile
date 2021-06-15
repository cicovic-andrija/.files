# Makefile for `tab`
#

VERSION := 0.1
BUILD := $(shell git rev-parse --short HEAD)

OBJ_DIR := obj
BIN_DIR := bin
DEP_DIR := .dep
INC_DIR := include

SRC_DIR_LIST := main
SRC_DIR_LIST += data

SRC := $(foreach dir,$(SRC_DIR_LIST),$(wildcard $(dir)/*.c))

OBJ := $(SRC:%.c=$(OBJ_DIR)/%.o)

OBJ_TREE := $(OBJ_DIR)
OBJ_TREE += $(foreach dir,$(SRC_DIR_LIST),$(OBJ_DIR)/$(dir))

DEP_TREE := $(DEP_DIR)
DEP_TREE += $(foreach dir,$(SRC_DIR_LIST),$(DEP_DIR)/$(dir))

CXX := gcc
CXXFLAGS = -c -m64 -std=c11 -pedantic -Wextra -Wall -Wshadow -I $(INC_DIR) -g -o $@
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEP_DIR)/$*.d
CPPFLAGS = -D 'TAB_VERSION="tab v$(VERSION) (build: $(BUILD))"'
LINKFLAGS = $$(ncursesw6-config --cflags --libs)
BIN := tab

install: $(BIN)
	@cp $(BIN_DIR)/$(BIN) $(HOME)/bin/$(BIN)

$(BIN): $(OBJ) | $(BIN_DIR)
	$(CXX) -o $(BIN_DIR)/$(BIN) $(OBJ) $(LINKFLAGS)

$(OBJ_DIR)/%.o: %.c $(DEP_DIR)/%.d | $(OBJ_DIR) $(DEP_DIR)
	$(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $<

$(OBJ_DIR):
	@mkdir -p $(OBJ_TREE)

$(DEP_DIR):
	@mkdir -p $(DEP_TREE)

$(BIN_DIR):
	@mkdir -p $@

.PHONY: tags
tags:
	@ctags --c-kinds=+defgstuv --extra=+q -f .tags -R .

.PHONY: clean
clean:
	@rm -rf $(OBJ_DIR) $(DEP_DIR) $(BIN_DIR) *.i *.s $(HOME)/bin/$(BIN)

DEP_FILES := $(SRC:%.c=$(DEP_DIR)/%.d)

$(DEP_FILES):

include $(wildcard $(DEP_FILES))
