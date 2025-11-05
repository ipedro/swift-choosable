import Foundation
import SwiftUI

// MARK: - SwiftUI Type Conformances

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

// MARK: - SwiftUI View Extensions

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

// MARK: - SwiftUI Shape Extensions

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

// MARK: - AnyShape Type

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AnyShape: Shape {
    let shape: any Shape

    init<S: Shape>(_ shape: S) {
        self.shape = shape
    }

    public func path(in rect: CGRect) -> Path {
        shape.path(in: rect)
    }

    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    public var layoutDirectionBehavior: LayoutDirectionBehavior {
        shape.layoutDirectionBehavior
    }

    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        shape.sizeThatFits(proposal)
    }
}
