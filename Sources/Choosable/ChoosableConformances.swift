import Foundation
import CoreGraphics

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
