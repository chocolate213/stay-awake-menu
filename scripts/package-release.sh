#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_NAME="Stay Awake"
INFO_PLIST="$ROOT_DIR/StayAwakeMenu/Info.plist"
VERSION="$(plutil -extract CFBundleShortVersionString raw -o - "$INFO_PLIST")"
RELEASE_DIR="$ROOT_DIR/release"
ARCHIVE_NAME="Stay-Awake-$VERSION-macOS"
ARCHIVE_PATH="$RELEASE_DIR/$ARCHIVE_NAME.zip"

"$ROOT_DIR/build-menu-app.sh" >/dev/null

rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"

ditto -c -k --sequesterRsrc --keepParent "$ROOT_DIR/dist/$APP_NAME.app" "$ARCHIVE_PATH"
(cd "$RELEASE_DIR" && shasum -a 256 "$ARCHIVE_NAME.zip" > "$ARCHIVE_NAME.zip.sha256")

printf '%s\n' "$ARCHIVE_PATH"
printf '%s\n' "$ARCHIVE_PATH.sha256"
