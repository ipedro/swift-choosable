import XCTest
@testable import Choosable

final class ChoosableTests: XCTestCase {

    // MARK: - Int

    func testIntOrMethod() {
        let original = 5
        let alternative = 10

        // When all conditions are true
        XCTAssertEqual(original.or(alternative, when: true, true), alternative)

        // When at least one condition is false
        XCTAssertEqual(original.or(alternative, when: true, false), original)
    }

    // MARK: - String

    func testStringOrMethod() {
        let original = "Hello"
        let alternative = "World"

        // When all conditions are true
        XCTAssertEqual(original.or(alternative, when: true, true), alternative)

        // When at least one condition is false
        XCTAssertEqual(original.or(alternative, when: false, true), original)
    }

    // MARK: - Optional<Int>

    func testOptionalIntOrMethod() {
        let original: Int? = 5
        let alternative: Int? = 10

        // When all conditions are true
        XCTAssertEqual(original.or(alternative, when: true, true), alternative)

        // When at least one condition is false
        XCTAssertEqual(original.or(alternative, when: false, true), original)
    }

    // MARK: - Collections

    func testArrayOrMethod() {
        let original = [1, 2, 3]
        let alternative = [4, 5, 6]

        // When all conditions are true
        XCTAssertEqual(original.or(alternative, when: true, true), alternative)

        // When at least one condition is false
        XCTAssertEqual(original.or(alternative, when: true, false), original)
    }

    // MARK: - NSObject

    private class MockNSObject: NSObject {}

    func testNSObjectOrMethod() {
        let original = MockNSObject()
        let alternative = MockNSObject()

        // When all conditions are true
        XCTAssertEqual(original.or(alternative, when: true), alternative)

        // When at least one condition is false
        XCTAssertEqual(original.or(alternative, when: false), original)
    }

}
