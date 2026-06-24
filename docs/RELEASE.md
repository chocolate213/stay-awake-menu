# Release Checklist

1. Update `CFBundleShortVersionString` and `CFBundleVersion` in `StayAwakeMenu/Info.plist`.
2. Review the source tree for local machine paths, organization-specific identifiers, generated artifacts, and stale experimental UI references.
3. Run `make verify`.
4. Run `make release`.
5. Create and push a version tag, for example `v1.0.0`, or run the Release workflow manually with an existing tag.
6. Confirm the GitHub Release contains the generated zip and checksum from `release/`.
7. On a clean macOS user account, unzip the app, launch it, and confirm the helper installs under Application Support.
8. Restart the clean account, launch the app again, and confirm the status starts as off and can be turned on from the menu bar.

The release build is ad-hoc signed for local distribution. For notarized public distribution, sign with a Developer ID Application certificate and submit the archive to Apple's notarization service.
