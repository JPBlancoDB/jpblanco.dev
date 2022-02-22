BASE_DIR := $(shell pwd)
EMACS_BUILD_DIR := /tmp/home-build

all: org2hugo

.PHONY: org2hugo
org2hugo:
	mkdir -p $(EMACS_BUILD_DIR)
	cp -r $(BASE_DIR)/* $(EMACS_BUILD_DIR)
    # Build temporary minimal EMACS installation separate from the one in the machine.
	HOME=$(EMACS_BUILD_DIR) emacs -Q --batch --load $(EMACS_BUILD_DIR)/init.el --execute "(build/export-all)" --kill
