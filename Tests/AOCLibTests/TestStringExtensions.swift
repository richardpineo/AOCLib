
import AOCLib
import XCTest

class TestStringExtensions: XCTestCase {
	func testLcm() throws {
		XCTAssertFalse("mjqj".isUnique)
		XCTAssertFalse("mjqm".isUnique)
		XCTAssertTrue("mjqw".isUnique)
	}
}
