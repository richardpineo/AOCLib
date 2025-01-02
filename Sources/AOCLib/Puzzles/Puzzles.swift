
import Foundation

@MainActor
public class Puzzles: ObservableObject {
	public func get(byId id: Int) -> Puzzle? {
		puzzles.first { $0.id == id }
	}

	public init(puzzles: [Puzzle]) {
		self.puzzles = puzzles
	}

	@Published public var puzzles: [Puzzle]

	public var ordered: [Puzzle] {
		puzzles.sorted { x, y in
			switch (x.name.isEmpty, y.name.isEmpty) {
			case (true, false): return false
			case (false, true): return true
			case (true, true): return x.id < y.id
			case (false, false): return x.id > y.id
			}
		}
	}
}
