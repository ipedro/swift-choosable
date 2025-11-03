This repository is a small Swift Package providing a single, focused protocol `Choosable` that
adds conditional selection helpers to many standard Swift types and SwiftUI views.

Keep instructions concise and actionable for code-generation assistants. Prefer edits that
preserve the library's tiny API surface and existing tests.

What this project contains
- `Choosable.swift` — single-source implementation. Contains:
  - Protocol `Choosable` and default extensions (`or(_:when:)` and `when(_:alternative:)`).
  - Conformances for primitives, optionals, collections, CoreGraphics and `NSObject`.
  - Conditional `SwiftUI` extensions (guarded by `#if canImport(SwiftUI)`).
- `ChoosableTests.swift` — unit tests that demonstrate expected behaviour for primitives,
  optionals, collections and `NSObject`.
- `Package.swift` — Swift Package manifest. The package exposes a library product named
  `Choosable` and uses local source files in the repository root.

Big-picture guidance for code changes
- Keep the public API minimal and source-compatible: the main contract is the `Choosable` protocol
  and the `or`/`when` helpers. Avoid introducing breaking API surface without version bump.
- Prefer small, well-tested additions. If adding new conformances, follow the pattern used
  in `Choosable.swift` (declare extensions for the type and ensure tests cover behaviour).
- SwiftUI code paths are optional and guarded. When modifying SwiftUI portions, keep
  availability attributes and `#if canImport(SwiftUI)` guards consistent with the file.

Developer workflows (commands to run)
- Run tests locally: `swift test` (package manifest is at repository root).
- Run swift-format / linting if available in contributor environment; there is no bundled
  formatter in the repo — follow the project's existing style (compact, inline docs).

Project-specific conventions and patterns
- Single-file implementation: most logic lives in `Choosable.swift`. Keep similar helpers
  colocated when they are tightly related to `Choosable` behaviour.
- Tests live at the repo root and import the `Choosable` product via `@testable import Choosable`.
- Conditional compilation: SwiftUI APIs are included only when SwiftUI is available; use
  `#if canImport(SwiftUI)` and appropriate availability annotations (`@available`) for symbols.

Integration points and external dependencies
- No external package dependencies. The package is designed to be drop-in via Swift Package
  Manager. When adding dependencies, update `Package.swift` and keep the package lightweight.

Examples to reference when generating code
- Adding a new primitive conformance (follow `extension Int: Choosable {}` pattern).
- Extending SwiftUI `View` with an overload should mirror the `or(when:alternative:)`
  implementation already present and preserve `@ViewBuilder` and return types like
  `_ConditionalContent<Self, V>`.

Tests and safety
- New behaviour must include unit tests in `ChoosableTests.swift` following existing
  test style (XCTest, simple assertions). Keep tests fast and deterministic.

When to ask for human review
- Any change that affects the public API semantics or the package manifest (`Package.swift`).
- Adding platform-specific behaviour (new availability requirements) or non-trivial
  algorithmic changes.

If something isn't discoverable in the repo (CI config, formatting rules, versioning policy),
ask the maintainer before making repository-wide changes.

Files to inspect for context: `Choosable.swift`, `ChoosableTests.swift`, `Package.swift`, `README.md`.

End of instructions.
