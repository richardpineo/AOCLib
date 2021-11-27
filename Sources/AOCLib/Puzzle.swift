
import Foundation
import SwiftUI

public enum SolutionState {
	case unsolved
	case solved
	case solvedA
}

public class Puzzle: Identifiable, ObservableObject {
	public typealias MakeSolver = () -> PuzzleSolver

	public init(year: Int, id: Int, name: String, maker: @escaping MakeSolver) {
		self.year = year
		self.id = id
		self.name = name
		makeSolver = maker

		solutionA = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true)) ?? ""
		solutionB = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false)) ?? ""
	}

	public var year: Int
	public var id: Int
	public var name: String

	private var makeSolver: MakeSolver

	public var solver: PuzzleSolver {
		makeSolver()
	}

	public var state: SolutionState {
		if solutionA.isEmpty {
			return .unsolved
		}
		return solutionB.isEmpty ? .solvedA : .solved
	}

	@Published public var solutionA: String {
		didSet {
			UserDefaults.standard.set(solutionA, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true))
		}
	}

	@Published public var solutionB: String {
		didSet {
			UserDefaults.standard.set(solutionB, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false))
		}
	}

	private static func userDefaultKey(year: Int, id: Int, isA: Bool) -> String {
		"puzzle_\(year)_\(id)_\(isA ? "A" : "B")"
	}
}
