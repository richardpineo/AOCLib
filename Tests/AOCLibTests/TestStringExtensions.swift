
import AOCLib
import XCTest

class TestStringExtensions: XCTestCase {
	func testUniqueness() throws {
		XCTAssertFalse("mjqj".isUnique)
		XCTAssertFalse("mjqm".isUnique)
		XCTAssertTrue("mjqw".isUnique)
	}
}
