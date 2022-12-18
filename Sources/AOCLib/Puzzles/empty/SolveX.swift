
import AOCLib
import Foundation

class SolveX: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("ExampleX") == 0
	}

	func solveBExamples() -> Bool {
		return solveB("ExampleX") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("InputX").description
	}

	func solveB() -> String {
		solveB("InputX").description
	}

	func solveA(_ fileName: String) -> Int {
		0
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
