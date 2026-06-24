#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAIN_FILE="$ROOT_DIR/StayAwakeMenu/main.m"

if ! grep -q -- '- (void)menuNeedsUpdate:(NSMenu \*)menu' "$MAIN_FILE"; then
  printf 'not ok - menu refresh must run from menuNeedsUpdate before first layout\n' >&2
  exit 1
fi

if grep -q -- '- (void)menuWillOpen:(NSMenu \*)menu' "$MAIN_FILE"; then
  printf 'not ok - menuWillOpen is too late to normalize first-open menu layout\n' >&2
  exit 1
fi

if grep -q -- '@selector(showAbout:)' "$MAIN_FILE"; then
  printf 'not ok - About item must not use a standard-looking showAbout: selector\n' >&2
  exit 1
fi

printf 'ok - menu source tests\n'
