APP_NAME := Stay Awake
APP_PATH := dist/$(APP_NAME).app
INSTALL_PATH := $(HOME)/Applications/$(APP_NAME).app

.PHONY: build install run clean verify release

build:
	./build-menu-app.sh

install: build
	ditto "$(APP_PATH)" "$(INSTALL_PATH)"

run: install
	open "$(INSTALL_PATH)"

verify: build
	plutil -lint "$(APP_PATH)/Contents/Info.plist"
	codesign --verify --deep --strict --verbose=2 "$(APP_PATH)"

release:
	./scripts/package-release.sh

clean:
	rm -rf dist build release DerivedData
