@DebugDescription
public struct Bearing: Hashable {
	public init(position: Position2D, heading: Heading) {
		self.position = position
		self.heading = heading
	}

	public var position: Position2D
	public var heading: Heading

	// Does not change the heading of the original bearing.
	public func offset(_ inDirection: Heading, _ distance: Int = 1) -> Bearing {
		.init(position: position.offset(inDirection, distance), heading: heading)
	}

	public func move(_ distance: Int = 1) -> Bearing {
		.init(position: position.offset(heading, distance), heading: heading)
	}

	public var debugDescription: String {
		"Bearing \(heading) at \(position.displayString)"
	}
}
