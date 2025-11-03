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

    func testWhenAlternativeIsLazy() {
        let original = 1
        var evaluated = false

        let result = original.when(false, alternative: {
            evaluated = true
            return 2
        })

        XCTAssertEqual(result, original)
        XCTAssertFalse(evaluated, "Alternative closure should not be evaluated when conditions are false")
    }

    func testOrAlternativeIsLazy() {
        let original = 0
        var evaluated = false

        let result = original.or({
            evaluated = true
            return 100
        }(), when: false)

        XCTAssertEqual(result, original)
        XCTAssertFalse(evaluated, "or(_:when:) alternative should be lazy via @autoclosure")
    }

}
