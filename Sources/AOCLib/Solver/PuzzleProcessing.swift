
import Foundation

public struct PuzzleProcessingId: Hashable {
	public var id: Int
	public var isA: Bool

	public var description: String {
		"Day \(id + 1)-\(isA ? "a" : "b")"
	}
}

public class PuzzleProcessing: ObservableObject {
	public enum ProcessingStatus {
		case idle
		case processing(Date)
	}

	public init(puzzles: Puzzles) {
		self.puzzles = puzzles
	}

	public static func application(puzzles: Puzzles) -> PuzzleProcessing {
		PuzzleProcessing(puzzles: puzzles)
	}

	public static func preview(puzzles: Puzzles) -> PuzzleProcessing {
		let processing = PuzzleProcessing(puzzles: puzzles)
		processing.status[.init(id: 1, isA: true)] = .processing(Date())
		return processing
	}

	// A map from puzzle ID and A/B to current processing status
	// If the value isn't in the map, then it's not processing.
	@Published public var status: [PuzzleProcessingId: ProcessingStatus] = [:]

	public func isProcessing(_ id: PuzzleProcessingId) -> Bool {
		guard let found = status[id] else {
			return false
		}
		switch found {
		case .processing: return true
		default:
			return false
		}
	}

	// Amount of time processing, if processing or nil otherwise.
	public func elapsed(_ id: PuzzleProcessingId) -> TimeInterval? {
		guard let found = status[id] else {
			return nil
		}
		switch found {
		case let .processing(start):
			return start.distance(to: Date())
		default:
			return nil
		}
	}

	public func startProcessing(_ id: PuzzleProcessingId) {
		if isProcessing(id) {
			return
		}
		status[id] = .processing(Date())

		DispatchQueue.global().async {
			// Self.log(id, "start")
			let solution = self.solve(id)

			// Report out
			DispatchQueue.main.async {
				if let puzzle = self.puzzles.get(byId: id.id) {
					if id.isA { puzzle.solutionA = solution }
					else { puzzle.solutionB = solution }
				}

				let bullet = solution.isEmpty ? (solution.isEmpty ? "🟡" : "🔴") : "🟢"
				let solutionDisplay = solution.padding(toLength: 16, withPad: " ", startingAt: 0)
				let elapsedDisplay = lround(self.elapsed(id)!.magnitude * 1000).description
				Self.log(id, "\(bullet) \(solutionDisplay) \(elapsedDisplay) ms")
				self.status[id] = .idle
			}
		}
	}

	public func clearAll() {
		puzzles.puzzles.forEach { puzzle in
			puzzle.solutionA = ""
			puzzle.solutionB = ""
		}
	}

	public func processAll() {
		clearAll()
		puzzles.puzzles.forEach { puzzle in
			startProcessing(.init(id: puzzle.id, isA: true))
			startProcessing(.init(id: puzzle.id, isA: false))
		}
	}

	private func solve(_ id: PuzzleProcessingId) -> String {
		let puzzle = puzzles.get(byId: id.id)

		guard let solver = puzzle?.solver else {
			return ""
		}

		return id.isA ? solver.solveA() : solver.solveB()
	}

	private static func log(_ id: PuzzleProcessingId, _ text: String) {
		let idStr = String(format: "%02d", id.id)
		print("\(idStr)\(id.isA ? "a" : "b"): \(text)")
	}

	private var puzzles: Puzzles
}
