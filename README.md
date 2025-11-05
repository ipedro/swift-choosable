# Choosable
[![License](https://img.shields.io/github/license/ipedro/swift-choosable)](https://github.com/ipedro/swift-choosable/blob/main/LICENSE) 
![Latest Version](https://img.shields.io/github/v/tag/ipedro/swift-choosable?label=Swift%20Package&sort=semver)
![Swift 5.7+](https://img.shields.io/badge/Swift-5.7+-orange.svg)

![iOS 10.0+](https://img.shields.io/badge/iOS-10.0+-lightblue.svg)
![macOS 10.14+](https://img.shields.io/badge/macOS-10.14+-lightblue.svg)
![tvOS 10.0+](https://img.shields.io/badge/tvOS-10.0+-lightblue.svg)
![watchOS 3.0+](https://img.shields.io/badge/watchOS-3.0+-lightblue.svg)

`Choosable` is a Swift protocol designed to empower objects with context-aware capabilities, allowing them to respond dynamically to conditions. By adopting `Choosable`, any Swift type can elegantly choose between itself and an alternative based on the truth value of given conditions.

This flexibility opens the door to cleaner, more readable conditional logic throughout your Swift projects—from feature flagging to adaptive UI elements, `Choosable` can streamline the way you handle binary decisions.

## Features

- 🔄 **Toggle Behavior**: Seamlessly switch between values or states.
- 🔍 **Context-Aware**: Make decisions based on runtime conditions.
- ✅ **Type-agnostic**: Works with any type, including custom types.
- 📦 **No External Dependencies**: Easy to integrate into any project.

## Installation

### Swift Package Manager

You can add `Choosable` to your project via Swift Package Manager. This package supports Swift 5.x toolchains and also provides a Swift 6 specific manifest (see notes).

Add the package dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/ipedro/swift-choosable.git", .upToNextMajor(from: "1.0.0"))
```

Notes about Swift versions

The repository provides two manifests to support multiple toolchains:

- `Package.swift` (default) — compatible with Swift 5.x toolchains.
- `Package@swift-6.swift` — used automatically by Swift 6+ toolchains and enables Swift 6 language mode.

This dual-manifest approach keeps the package buildable on older toolchains while enabling Swift 6 features for newer toolchains.

## Usage

Integrating `Choosable` into your types is straightforward:

```swift
extension MyType: Choosable {}
```

Once conformed, the `or(_:when:)` method is available to elegantly handle conditional logic:

```swift
let item = myDefaultItem.or(anotherItem, when: someCondition)
```

### Examples

#### Primitives

```swift
let discount = 0.0.or(15.0, when: isHolidaySeason) // Returns 15.0 if `isHolidaySeason` is true
```

#### Optionals

```swift
let user = currentUser.or(defaultUser, when: currentUser == nil) // Returns `defaultUser` if `currentUser` is nil
```

#### Collections

```swift
let data = cachedData.or(freshData, when: isCacheExpired) // Returns `freshData` if `isCacheExpired` is true
```

#### Custom Types

```swift
struct FeatureFlag: Choosable {
    let isEnabled: Bool
}

let featureA = FeatureFlag(isEnabled: true)
let featureB = FeatureFlag(isEnabled: false)
let featureC = FeatureFlag(isEnabled: false)

// Given a condition, choose `featureA`, `featureB` or `featureC`.
// In this case, `isEnabled` flag is true, so `featureA` will be chosen.
let activeFeature = featureA
    .or(featureB, when: featureA.isEnabled)
    .or(featureC, when: featureB.isEnabled)
```

#### Adaptive UI Elements

```swift
import SwiftUI

struct AdaptiveTextColor: View {
    @State 
    private var isSelected: Bool = false
    
    @Environment(\.isEnabled)
    private var isEnabled

    var body: some View {
        Text("Hello, Choosable!")
            .foregroundColor(Color.black
                .or(Color.white, when: isSelected)
                .or(Color.gray, when: !isEnabled)
            )
            .background { Color.red }
    }
}

struct AdaptiveFontStyle: View {
    @State private var isHorizontal: Bool = false

    var body: some View {
        Text("Dynamic Font Size")
            .font(.body.or(.largeTitle, when: isHorizontal))
    }
}
```

### Chaining and evaluation order

The `or` and `when` helpers are lazy: alternatives are only evaluated when all supplied
conditions are true. In chains, each `or` is only reached when the previous call returned the
receiver (i.e. previous conditions were false). Example:

```swift
var aEvaluated = false
var bEvaluated = false

func makeA() -> Int { aEvaluated = true; return 1 }
func makeB() -> Int { bEvaluated = true; return 2 }

let original = 0

// Scenario: first `.or` conditions true -> `makeA` evaluated, chain short-circuits
let result1 = original.or(makeA(), when: true).or(makeB(), when: true)
// result1 == 1, aEvaluated == true, bEvaluated == false

// Scenario: first `.or` false -> second `.or` is reached and `makeB` evaluated
let result2 = original.or(makeA(), when: false).or(makeB(), when: true)
// result2 == 2, aEvaluated == false for this run, bEvaluated == true
```

## License

`Choosable` is released under the MIT license. See [LICENSE](LICENSE) for details.
