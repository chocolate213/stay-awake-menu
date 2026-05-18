# Changelog

## 1.0.0

- Added native AppKit menu bar controller for the bundled `stay-awake` helper.
- Added runtime helper installation into the current user's Application Support directory.
- Added English and Simplified Chinese localizations.
- Added an image-generated `AppIcon.icns` for Finder, Launchpad, and Applications views.
- Added an SF Symbol status bar icon configured through `NSStatusBarButton`.
- Added project documentation and Makefile targets for build, install, run, verify, and clean.
- Added GitHub Actions CI and release archive packaging.
- Quit now always stops the active wake lock before exiting the menu app.
