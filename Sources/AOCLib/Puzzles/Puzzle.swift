
import Foundation
import SwiftUI

public enum SolutionState {
	case unsolved
	case solved
	case solvedA
}

@MainActor
public class Puzzle: @preconcurrency Identifiable, ObservableObject {
	public typealias MakeSolver = () -> PuzzleSolver

	public init(year: Int, id: Int, name: String, maker: @escaping MakeSolver) {
		self.year = year
		self.id = id
		self.name = name
		makeSolver = maker

		solutionA = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true, isExample: false)) ?? ""
		exampleA = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true, isExample: true)) ?? ""
		solutionB = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false, isExample: false)) ?? ""
		exampleB = UserDefaults.standard.string(forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false, isExample: true)) ?? ""
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
			UserDefaults.standard.set(solutionA, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true, isExample: false))
		}
	}

	@Published public var exampleA: String {
		didSet {
			UserDefaults.standard.set(solutionA, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: true, isExample: true))
		}
	}

	@Published public var solutionB: String {
		didSet {
			UserDefaults.standard.set(solutionB, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false, isExample: false))
		}
	}

	@Published public var exampleB: String {
		didSet {
			UserDefaults.standard.set(solutionB, forKey: Puzzle.userDefaultKey(year: year, id: id, isA: false, isExample: true))
		}
	}

	private static func userDefaultKey(year: Int, id: Int, isA: Bool, isExample: Bool) -> String {
		"puzzle_\(year)_\(id)_\(isA ? "A" : "B")_\(isExample ? "Ex" : "Ans")"
	}
}
