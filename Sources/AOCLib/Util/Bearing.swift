@DebugDescription
struct Bearing: Hashable {
	var position: Position2D
	var heading: Heading
	
	// Does not change the heading of the original bearing.
	func offset(_ inDirection: Heading, _ distance: Int = 1) -> Bearing {
		.init(position: position.offset(inDirection, distance), heading: heading)
	}
	
	func move(_ distance: Int = 1) -> Bearing {
		.init(position: position.offset(heading, distance), heading: heading)
	}
	
	var debugDescription: String {
		"Bearing \(heading) at \(position.displayString)"
	  }
}
