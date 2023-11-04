# Choosable

![Swift 5.9+](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![Xcode 15.0+](https://img.shields.io/badge/Xcode-15.0+-blue.svg)
![iOS 10.0+](https://img.shields.io/badge/iOS-10.0+-lightgrey.svg)
![macOS 10.14+](https://img.shields.io/badge/macOS-10.14+-lightgrey.svg)
![tvOS 10.0+](https://img.shields.io/badge/tvOS-10.0+-lightgrey.svg)
![watchOS 3.0+](https://img.shields.io/badge/watchOS-3.0+-lightgrey.svg)

`Choosable` is a Swift protocol designed to empower objects with context-aware capabilities, allowing them to respond dynamically to conditions. By adopting `Choosable`, any Swift type can elegantly choose between itself and an alternative based on the truth value of given conditions.

This flexibility opens the door to cleaner, more readable conditional logic throughout your Swift projects—from feature flagging to adaptive UI elements, `Choosable` can streamline the way you handle binary decisions.

## Features

- 🔄 **Toggle Behavior**: Seamlessly switch between values or states.
- 🔍 **Context-Aware**: Make decisions based on runtime conditions.
- ✅ **Type-agnostic**: Works with any type, including custom types.
- 📦 **No External Dependencies**: Easy to integrate into any project.

## Installation

### Swift Package Manager

You can add `Choosable` to your project via Swift Package Manager, by adding the following to your `Package.swift` file in the `dependencies` array:

```swift
.package(url: "https://github.com/ipedro/swift-choosable.git", .upToNextMajor(from: "1.0.0"))
```

## Usage

Integrating `Choosable` into your types is straightforward:

```swift
extension MyType: Choosable {}
```

Once conformed, the `choose(_:when:)` method is available to elegantly handle conditional logic:

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

let feature = disabledFeature.or(enabledFeature, when: user.isPremium) // Returns `enabledFeature` if `user.isPremium` is true
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
    @State 
    private var isHorizontal: Bool = false

    var body: some View {
        Text("Dynamic Font Size")
            .font(.body.or(.largeTitle, when: isHorizontal))
        }
    }
```

## License

`Choosable` is released under the MIT license. See [LICENSE](LICENSE) for details.
