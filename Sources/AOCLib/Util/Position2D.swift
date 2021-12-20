
import Foundation

public struct Position2D: Comparable, Positional {
	public init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	public init(from arrayIndex: Int, numCols: Int) {
		x = arrayIndex % numCols
		y = arrayIndex / numCols
	}

	public static var origin: Position2D { Position2D(0, 0) }

	public var x: Int
	public var y: Int

	public var displayString: String {
		"(\(x),\(y))"
	}

	public func offset(_ x: Int, _ y: Int) -> Position2D {
		Position2D(self.x + x, self.y + y)
	}

	public func offset(_ step: Position2D) -> Position2D {
		offset(step.x, step.y)
	}

	public func arrayIndex(numCols: Int) -> Int {
		x + y * numCols
	}

	public func cityDistance(_ from: Position2D = .origin) -> Int {
		abs(x - from.x) + abs(y - from.y)
	}

	public static func < (lhs: Position2D, rhs: Position2D) -> Bool {
		lhs.x == rhs.x ? lhs.y < rhs.y : lhs.x < rhs.x
	}

	// Returns positions in order, top left to bottom right.
	public func neighbors(includeSelf: Bool) -> [Position2D] {
		var ns: [Position2D] = []
		for y in -1 ... 1 {
			for x in -1 ... 1 {
				let pos = Position2D(x, y)
				if includeSelf || pos != .origin {
					ns.append(pos)
				}
			}
		}
		return ns.map { self.offset($0) }
	}
}
