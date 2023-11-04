# Choosable

`Choosable` is a protocol that provides context-aware behavior to an object.
It allows an object to adapt its state or return different content based on a set of conditions.

By conforming to `Choosable`, any type gains the ability to evaluate one or more conditions
and, based on their values, return the original instance or an alternative. This can be useful
in many situations where you need to toggle between two states, values, or contents
depending on certain conditions at runtime.

## Usage Examples:

```swift
// For primitive types
let chosenNumber = 42.or(100, when: false) // Returns 42

// For optional types
let optionalString: String? = "Hello"
let defaultString = "Default"
let chosenString = optionalString.or(defaultString, when: optionalString == nil) // Returns "Hello"

// For collections
let primaryColors = ["Red", "Yellow", "Blue"]
let secondaryColors = ["Green", "Purple", "Orange"]
let chosenColors = primaryColors.or(secondaryColors, when: primaryColors.isEmpty) // Returns primaryColors

// Your types
struct FeatureFlag: Choosable {
    let isEnabled: Bool
}

let featureA = FeatureFlag(isEnabled: true)
let featureB = FeatureFlag(isEnabled: true)
let featureC = FeatureFlag(isEnabled: false)

// Given a condition, choose `featureA`, `featureB` or `featureC`.
// In this case, `isEnabled` flag is true for both A and C, so `featureC` will be chosen.
let activeFeature: FeatureFlag = featureA
    .or(featureB, when: featureA.isEnabled)
    .or(featureC, when: featureB.isEnabled)
```
