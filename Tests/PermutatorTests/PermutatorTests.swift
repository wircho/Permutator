import XCTest
@testable import Permutator

final class PermutatorTests: XCTestCase {
    func testPermutator() {
        XCTAssertEqual(Set(Array(Permutation(6))), Set([0, 1, 2, 3, 4, 5]))
    }

    static var allTests = [
        ("testPermutator", testPermutator),
    ]
}
