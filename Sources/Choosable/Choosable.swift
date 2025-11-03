// Copyright (c) 2023 Pedro Almeida
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/// `Choosable` is a protocol that provides context-aware behavior to an object.
/// It allows an object to adapt its state or return different content based on a set of conditions.
///
/// By conforming to `Choosable`, any type gains the ability to evaluate one or more conditions
/// and, based on their values, return the original instance or an alternative. This can be useful
/// in many situations where you need to toggle between two states, values, or contents
/// depending on certain conditions at runtime.
///
/// ## Usage Examples:
///
/// For primitive types:
/// ```
/// let chosenNumber = 42.or(100, when: false) // Returns 42
/// ```
///
/// For optional types:
/// ```
/// let optionalString: String? = "Hello"
/// let defaultString = "Default"
/// let chosenString = optionalString.or(defaultString, when: optionalString == nil) // Returns "Hello"
/// ```
/// For collections:
/// ```
/// let primaryColors = ["Red", "Yellow", "Blue"]
/// let secondaryColors = ["Green", "Purple", "Orange"]
/// let chosenColors = primaryColors.or(secondaryColors, when: primaryColors.isEmpty) // Returns primaryColors
/// ```
/// Custom types:
/// ```
/// struct FeatureFlag: Choosable {
///     let isEnabled: Bool
/// }
///
/// let featureA = FeatureFlag(isEnabled: true)
/// let featureB = FeatureFlag(isEnabled: false)
///
/// // Given a condition, choose `featureA` or `featureB`.
/// // In this case, `isEnabled` flag is true, so `featureA` will be chosen.
/// let activeFeature = featureA.or(featureB, when: featureA.isEnabled)
/// ```
///
///
public protocol Choosable {}

public extension Choosable {
    /// Returns either the current object or an alternative based on the evaluation of boolean conditions.
    ///
    /// This method takes a variable number of boolean conditions and checks them.
    /// If any condition is false, it returns `self`, the current object; otherwise, it returns
    /// the alternative object. The conditions are evaluated in order, and as soon as a false
    /// condition is found, the evaluation stops.
    ///
    /// - Parameters:
    ///   - alternative: The object to return if all conditions evaluate to true.
    ///   - conditions: A variadic parameter that takes a list of boolean conditions.
    /// - Returns: The original object if any condition is false; otherwise, the alternative.
    func or(_ alternative: Self, when conditions: Bool...) -> Self {
        conditions.contains { $0 == false } ? self : alternative
    }

    /// Returns either the current object or an alternative based on the evaluation of boolean conditions.
    ///
    /// This method takes a variable number of boolean conditions and checks them.
    /// If any condition is false, it returns `self`, the current object; otherwise, it returns
    /// the alternative object. The conditions are evaluated in order, and as soon as a false
    /// condition is found, the evaluation stops.
    ///
    /// - Parameters:
    ///   - conditions: A variadic parameter that takes a list of boolean conditions.
    ///   - alternative: The object to return if all conditions evaluate to true.
    /// - Returns: The original object if any condition is false; otherwise, the alternative.
    func when(_ conditions: Bool..., alternative: () -> Self) -> Self {
        conditions.contains { $0 == false } ? self : alternative()
    }
}

// MARK: - Primitive Data Types Conformance

extension Bool: Choosable {}
extension Int: Choosable {}
extension String: Choosable {}
extension Double: Choosable {}
extension CGFloat: Choosable {}
extension Float: Choosable {}
extension URL: Choosable {}

// MARK: - Optional Conformance

extension Optional: Choosable {}

// MARK: - Collection Types Conformance

extension Array: Choosable {}
extension Set: Choosable {}
extension Dictionary: Choosable {}

// MARK: - CoreGraphics Types Conformance
extension CGRect: Choosable {}
extension CGSize: Choosable {}
extension CGPoint: Choosable {}
extension CGAffineTransform: Choosable {}
extension CGVector: Choosable {}
extension CGRectEdge: Choosable {}

// MARK: - Obj-C

extension NSObject: Choosable {}

#if canImport(SwiftUI)
// MARK: - SwiftUI

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Alignment: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Animation: Choosable {}
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AnyShapeStyle: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Edge.Set: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Edge: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EdgeInsets: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension HorizontalAlignment: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension TextAlignment: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension VerticalAlignment: Choosable {}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension BlendMode: Choosable {}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    /// Returns either the current view or an alternative based on the evaluation of boolean conditions.
    ///
    /// This method takes a variable number of boolean conditions and checks them.
    /// If any condition is false, it returns `self`, the current view; otherwise, it returns
    /// the alternative view. The conditions are evaluated in order, and as soon as a false
    /// condition is found, the evaluation stops.
    ///
    /// - Parameters:
    ///   - conditions: A variadic parameter that takes a list of boolean conditions.
    ///   - alternative: A view builder that returns if all conditions evaluate to true.
    /// - Returns: The original view if any condition is false; otherwise, the alternative.
    @ViewBuilder
    func or<V>(when conditions: Bool..., @ViewBuilder alternative: () -> V) -> _ConditionalContent<Self, V> where V: View {
        if conditions.contains(where: { $0 == false }) { self }
        else { alternative() }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Shape {
    /// Returns either the current shape or an alternative based on the evaluation of boolean conditions.
    ///
    /// This method takes a variable number of boolean conditions and checks them.
    /// If any condition is false, it returns `self`, the current shape; otherwise, it returns
    /// the alternative shape. The conditions are evaluated in order, and as soon as a false
    /// condition is found, the evaluation stops.
    ///
    /// - Parameters:
    ///   - conditions: A variadic parameter that takes a list of boolean conditions.
    ///   - alternative: The shape to return if all conditions evaluate to true.
    /// - Returns: The original shape if any condition is false; otherwise, the alternative.
    func or<S>(when conditions: Bool..., alternative: () -> S) -> AnyShape where S: Shape {
        if conditions.contains(where: { $0 == false }) { return AnyShape(self) }
        else { return AnyShape(alternative()) }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AnyShape: Shape {
    let shape: any Shape

    init<S: Shape>(_ shape: S) {
        self.shape = shape
    }

    public func path(in rect: CGRect) -> Path {
        shape.path(in: rect)
    }

    #if swift(>=5.9)
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    public var layoutDirectionBehavior: LayoutDirectionBehavior {
        shape.layoutDirectionBehavior
    }
    #endif

    #if swift(>=5.8)
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        shape.sizeThatFits(proposal)
    }
    #endif
}
#endif
