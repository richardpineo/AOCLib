
import Foundation

@objc public protocol PuzzleSolver {
	// Tries to solve part A and B
	func solveA() -> String
	func solveB() -> String

	@objc optional var shouldTestA: Bool { get }
	@objc optional var shouldTestB: Bool { get }
	@objc optional var shouldTestExamplesA: Bool { get }
	@objc optional var shouldTestExamplesB: Bool { get }

	// The correct answers for part A and B, if known
	var answerA: String { get }
	var answerB: String { get }

	// Hooks to solve the examples.
	func solveAExamples() -> Bool
	func solveBExamples() -> Bool
}

class EmptySolver: PuzzleSolver {
	func solveA() -> String {
		""
	}

	func solveB() -> String {
		""
	}

	var answerA = ""
	var answerB = ""

	func solveAExamples() -> Bool {
		false
	}

	func solveBExamples() -> Bool {
		false
	}
}
