# AGENTS.md

## Project Overview

Stay Awake is a small native macOS menu bar app written in Objective-C and AppKit. It installs a bundled `stay-awake` helper into the current user's Application Support directory and uses the system `caffeinate` command to keep the Mac awake.

## Build And Verification

- Build the app with `make build`.
- Run the standard local verification with `make verify`.
- Create a distributable archive with `make release`.
- Remove generated artifacts with `make clean` before preparing source-only changes.

Generated artifacts live under `build/`, `dist/`, and `release/`; do not commit them.

## Code Guidelines

- Keep the app portable. Do not add developer-machine absolute paths such as user home directories, local bin paths, or temporary workspace paths.
- Do not add organization-specific, employee-specific, or local workstation identifiers to source, docs, comments, generated metadata, or release assets.
- Do not commit generated artifacts such as `.app` bundles, iconsets, release archives, checksums, DerivedData, or local screenshots.
- Do not add one-off preflight scripts whose main purpose is to scan the repository for local-machine strings; keep this guidance here and use human review before publishing.
- Use Foundation directory APIs such as `NSApplicationSupportDirectory` for runtime files.
- Keep the helper script bundled under `StayAwakeMenu/Resources/Scripts/` and copy it into Application Support at runtime.
- Preserve the current localization pattern. User-visible strings belong in both `en.lproj/Localizable.strings` and `zh-Hans.lproj/Localizable.strings`.
- Preserve the status bar icon approach: use SF Symbols as template images through `NSStatusBarButton` so AppKit controls menu bar rendering.
- Keep app icon generation reproducible through `StayAwakeMenu/Assets/AppIconSource.png` and `tools/prepare_app_icon.m`.

## Release Notes

- `Makefile` targets are the source of truth for local build, install, verify, clean, and release workflows.
- `docs/RELEASE.md` contains the manual release checklist.
- Public distribution beyond local/ad-hoc builds requires Developer ID signing and notarization.
