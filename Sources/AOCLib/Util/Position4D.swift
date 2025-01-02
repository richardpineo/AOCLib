
import Foundation

public struct Position4D: Hashable, Positional, Sendable {
	public init(_ x: Int, _ y: Int, _ z: Int, _ w: Int) {
		self.x = x
		self.y = y
		self.z = z
		self.w = w
	}

	public init(_ x: Int, _ y: Int) {
		self.init(x, y, 0, 0)
	}

	public static let origin = Position4D(0, 0, 0, 0)

	public var x: Int
	public var y: Int
	public var z: Int
	public var w: Int

	public var displayString: String {
		"(\(x),\(y), \(z), \(w)"
	}

	public func offset(_ x: Int, _ y: Int, _ z: Int, _ w: Int) -> Position4D {
		Position4D(self.x + x, self.y + y, self.z + z, self.w + w)
	}

	public func offset(_ step: Position4D) -> Position4D {
		offset(step.x, step.y, step.z, step.w)
	}

	public func cityDistance(_ from: Position4D = .origin) -> Int {
		abs(x - from.x) + abs(y - from.y) + abs(z - from.z)
	}

	public func neighbors(includeSelf: Bool) -> [Position4D] {
		var ns: [Position4D] = []
		for x in -1 ... 1 {
			for y in -1 ... 1 {
				for z in -1 ... 1 {
					for w in -1 ... 1 {
						let pos = Position4D(x, y, z, w)
						if includeSelf || pos != .origin {
							ns.append(pos)
						}
					}
				}
			}
		}
		return ns.map { self.offset($0) }
	}
}
