
import Foundation

public struct Grid2D: Hashable {
	public init(fileName: String) {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		self.init(lines: values)
	}

	public init(lines: [String]) {
		maxPos = .init(lines[0].count, lines.count)
		values = []
		for line in lines {
			for item in line {
				values.append(Character(String(item)))
			}
		}
	}

	public init(positions: [Position2D], value: Character) {
		maxPos = Position2D(
			positions.max { $0.x < $1.x }!.x + 1,
			positions.max { $0.y < $1.y }!.y + 1
		)
		values = [Character](repeating: "0", count: maxPos.arrayIndex(numCols: maxPos.x))
		for position in positions {
			setValue(position, value)
		}
	}

	public init(maxPos: Position2D, initialValue: Character) {
		self.maxPos = maxPos
		values = [Character](repeating: initialValue, count: maxPos.arrayIndex(numCols: maxPos.x - 1))
	}

	private init(maxPos: Position2D, values: [Character]) {
		self.maxPos = maxPos
		self.values = values
	}

	public func clone() -> Grid2D {
		.init(maxPos: maxPos, values: values)
	}

	public var maxPos: Position2D

	public var allPositions: [Position2D] {
		var positions: [Position2D] = []
		for x in 0 ..< maxPos.x {
			for y in 0 ..< maxPos.y {
				positions.append(.init(x, y))
			}
		}
		return positions
	}

	public func col(_ y: Int) -> String {
		if y >= maxPos.x {
			return ""
		}
		return (0 ..< maxPos.y).reduce("") {
			$0 + String(value(.init(y, $1)))
		}
	}

	public func row(_ x: Int) -> String {
		if x >= maxPos.y {
			return ""
		}

		return (0 ..< maxPos.x).reduce("") {
			$0 + String(value(.init($1, x)))
		}
	}

	public func valid(_ pos: Position2D) -> Bool {
		pos.x >= 0 && pos.y >= 0 && pos.x < maxPos.x && pos.y < maxPos.y
	}

	public func value(_ pos: Position2D) -> Character {
		values[pos.arrayIndex(numCols: maxPos.x)]
	}

	public func safeValue(_ pos: Position2D) -> Character? {
		if !valid(pos) {
			return nil
		}
		return value(pos)
	}

	public mutating func setValue(_ pos: Position2D, _ i: Character) {
		values[pos.arrayIndex(numCols: maxPos.x)] = i
	}

	public func allSatisfy(_ pred: (Character) -> Bool) -> Bool {
		values.allSatisfy { pred($0) }
	}

	public func neighbors(_ pos: Position2D, includePos: Bool, includeDiagonals: Bool = false) -> [Position2D] {
		pos.neighbors(includeSelf: includePos)
			.filter { includeDiagonals || $0.cityDistance(pos) < 2 }
			.filter { valid($0) }
	}

	public var debugDisplay: String {
		debugDisplay { String($0) }
	}

	public func debugDisplay(convert: (Character) -> String) -> String {
		var s = ""
		for y in 0 ..< maxPos.y {
			for x in 0 ..< maxPos.x {
				s += convert(value(.init(x, y)))
			}
			s += "\n"
		}
		return s
	}

	private var values: [Character]
}
