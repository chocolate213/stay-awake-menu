# Stay Awake

A tiny native macOS menu bar app for keeping your Mac awake on demand.

The app bundles its own helper script. On first launch, it installs that helper into the current user's Application Support directory and uses it to control the system `caffeinate` command.

## Features

- Native AppKit menu bar app with no Dock icon.
- One-click menu toggle for the bundled `stay-awake` helper.
- Installs the helper script into Application Support at runtime, so the app is not tied to any developer machine path.
- Shared state with the optional CLI helper through the app's Application Support directory.
- Localized UI for English and Simplified Chinese, selected by macOS language preferences.
- Image-generated macOS app icon packaged as `AppIcon.icns`.
- SF Symbol status bar icon configured through `NSStatusBarButton`: `moon.stars.fill` when on, `moon.zzz.fill` when off.

## Requirements

- macOS 11.0 or later.

Building from source also requires Xcode Command Line Tools.

## Install

Download the latest `Stay-Awake-<version>-macOS.zip` from GitHub Releases, unzip it, then move `Stay Awake.app` to your Applications folder.

```text
/Applications/Stay Awake.app
```

Launch the app from Applications. It is a menu bar app, so it does not appear in the Dock; look for the moon icon in the macOS status bar.

If macOS blocks the first launch because the app is not notarized, right-click `Stay Awake.app`, choose Open, then confirm Open once. Future launches should work normally.

On first launch, the app installs its bundled helper script under the current user's Application Support directory:

```text
~/Library/Application Support/local.stay-awake.menu/
```

## Usage

- `moon.zzz.fill`: Stay Awake is off.
- `moon.stars.fill`: Stay Awake is on.
- Click the menu bar icon and choose Turn Stay Awake On/Off to toggle.
- Choose Quit to stop `caffeinate` and exit the menu app.

## Install From Source

Clone the repository and enter the project directory:

```bash
git clone <repository-url>
cd stay-awake-menu
```

Build, install, and launch the app:

```bash
make run
```

This compiles the app and installs it to:

```text
~/Applications/Stay Awake.app
```

For a build-only workflow:

```bash
make build
```

The built app bundle is created at:

```text
dist/Stay Awake.app
```

The app is an agent app (`LSUIElement=true`), so it appears in the macOS status bar instead of the Dock.

The app does not register itself as a login item. After a restart, launch `Stay Awake.app` from Applications to show the menu bar icon again, or add it manually in System Settings > General > Login Items.

## Package A Release

```bash
make verify
make release
```

This creates a distributable zip and SHA-256 checksum in `release/`.

## Optional CLI Toggle

The menu bar app installs the helper script on launch. For terminal-only workflows after the app has launched once, this repository also includes:

```text
scripts/stay-awake-toggle
```

It uses the same installed helper and state file as the app, so CLI and menu bar status stay in sync.

## Uninstall

Quit the app from the menu bar, delete `Stay Awake.app`, then remove the helper state directory if you want a full cleanup:

```bash
rm -rf "$HOME/Library/Application Support/local.stay-awake.menu"
```
