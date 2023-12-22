import AOCLib
import XCTest

class TestGrid2D: XCTestCase {
	func testRowCol() throws {
		
		let gridValues = [
			"ABC",
			"DEF",
			"GHI",
			"JKL"
		]
		let grid: Grid2D = .init(lines: gridValues)
				
		XCTAssertEqual(grid.row(1), "DEF")
		XCTAssertEqual(grid.row(3), "JKL")
		XCTAssertEqual(grid.row(77), "")

		XCTAssertEqual(grid.col(1), "BEHK")
		XCTAssertEqual(grid.col(3), "")
		XCTAssertEqual(grid.col(77), "")
	}
}
