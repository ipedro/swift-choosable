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

    func testZeroConditionsChooseAlternative() {
        let original = 1
        let alternative = 2

        // No conditions means 'allSatisfy' over an empty collection -> true, so alternative is chosen.
        XCTAssertEqual(original.or(alternative), alternative)
    }

    func testOptionalNilBehavior() {
        let original: Int? = nil
        let alternative: Int? = 10

        XCTAssertEqual(original.or(alternative, when: original == nil), alternative)
        XCTAssertEqual(original.or(alternative, when: false), original)
    }

    func testSetAndDictionaryConformance() {
        let originalSet: Set = [1]
        let alternativeSet: Set = [2]

        XCTAssertEqual(originalSet.or(alternativeSet, when: true, true), alternativeSet)
        XCTAssertEqual(originalSet.or(alternativeSet, when: false, true), originalSet)

        let originalDict = ["a": 1]
        let alternativeDict = ["b": 2]

        XCTAssertEqual(originalDict.or(alternativeDict, when: true), alternativeDict)
        XCTAssertEqual(originalDict.or(alternativeDict, when: false), originalDict)
    }

    func testAlternativeEvaluatedWhenAllConditionsTrue() {
        let original = 0
        var evaluated = false

        func makeAlternative() -> Int {
            evaluated = true
            return 7
        }

        let result = original.or(makeAlternative(), when: true, true)
        XCTAssertEqual(result, 7)
        XCTAssertTrue(evaluated)
    }

    func testChainingEvaluationScenarios() {
        let original = 0
        var evalA = false
        var evalB = false

        func makeA() -> Int { evalA = true; return 1 }
        func makeB() -> Int { evalB = true; return 2 }

        // Scenario 1: first alternative chosen, second condition false -> only A evaluated
        evalA = false; evalB = false
        let _ = original.or(makeA(), when: true).or(makeB(), when: false)
        XCTAssertTrue(evalA)
        XCTAssertFalse(evalB)

        // Scenario 2: first condition false, second true -> only B evaluated
        evalA = false; evalB = false
        let _ = original.or(makeA(), when: false).or(makeB(), when: true)
        XCTAssertFalse(evalA)
        XCTAssertTrue(evalB)
    }

}
