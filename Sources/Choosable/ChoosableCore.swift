import Foundation

public extension Choosable {
    /// Returns either the current object or a lazily-evaluated alternative.
    ///
    /// The `alternative` parameter is an `@autoclosure`, so the expression passed as the
    /// alternative is not evaluated unless all `conditions` are true. This keeps typical
    /// call sites ergonomic while avoiding unnecessary work when conditions short-circuit.
    ///
    /// Chaining behaviour:
    /// - In a chain such as `x.or(a, when: c1).or(b, when: c2)`, `a` is only evaluated if `c1` is true.
    /// - `b` is only evaluated if the chain reached the second `.or` (i.e. `c1` was true) and then `c2` is true.
    ///
    /// Note about side-effects: because the alternative is lazy, any side-effects inside the
    /// alternative expression will only occur if the conditions are satisfied. If your
    /// alternative relies on side-effects, prefer passing an explicit closure or perform side-effects
    /// before calling `or` for clarity.
    @inlinable
    func or(_ alternative: @autoclosure () -> Self, when conditions: Bool...) -> Self {
        conditions.allSatisfy { $0 } ? alternative() : self
    }

    /// Returns either the current object or the result of the provided `alternative` closure.
    ///
    /// The `alternative` is a closure to make laziness explicit and to support trailing-closure
    /// syntax (handy for SwiftUI views). The closure is only evaluated when all `conditions` are true.
    ///
    /// Use this overload when the alternative is non-trivial (contains builders or view construction)
    /// or when you prefer an explicit closure for readability.
    @inlinable
    func when(_ conditions: Bool..., alternative: () -> Self) -> Self {
        conditions.allSatisfy { $0 } ? alternative() : self
    }
}
