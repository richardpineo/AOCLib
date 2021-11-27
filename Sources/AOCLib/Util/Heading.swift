
import Foundation

public enum Heading {
	case north
	case east
	case south
	case west

	public var rightwards: Heading {
		switch self {
		case .north: return .east
		case .east: return .south
		case .south: return .west
		case .west: return .north
		}
	}

	public var leftwards: Heading {
		switch self {
		case .north: return .west
		case .east: return .north
		case .south: return .east
		case .west: return .south
		}
	}

	public func turn(right: Bool) -> Heading {
		right ? rightwards : leftwards
	}

	public func turn(right: Bool, _ numTurns: Int = 1) -> Heading {
		var heading = self
		for _ in 0 ..< numTurns {
			heading = right ? heading.rightwards : heading.leftwards
		}
		return heading
	}

	public func turnRight(_ numTurns: Int = 1) -> Heading {
		turn(right: true, numTurns)
	}

	public func turnLeft(_ numTurns: Int = 1) -> Heading {
		turn(right: false, numTurns)
	}

	// Degrees rotated from facing east.
	public var clockwiseFromEast: Int {
		switch self {
		case .north: return 270
		case .east: return 0
		case .south: return 90
		case .west: return 180
		}
	}
}
