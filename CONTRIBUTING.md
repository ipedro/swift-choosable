# Contributing

Thanks for considering contributions! This project intentionally supports multiple Swift toolchains.

Manifests

- `Package.swift` — default manifest that targets Swift 5.x toolchains.
- `Package@swift-6.swift` — optional manifest that Swift 6+ toolchains will pick up automatically and which
  enables Swift 6 language mode.

Running tests locally

- Default (your installed toolchain):

```bash
swift test
```

- Run tests with a specific toolchain (example using `swiftenv` or installed toolchain):

```bash
# use a Swift 6 toolchain if installed
swift --version
# then run tests
swift test
```

If you need to install a different Swift toolchain for macOS, consider using `swiftenv` or Xcode toolchains.

Pull requests

- Keep changes small and focused.
- Add unit tests for new behavior and keep them deterministic.
- If you modify public API, open an issue first so we can discuss versioning.

Thank you!
