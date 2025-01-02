
import SwiftUI

struct PuzzleCard: View {
	@ObservedObject var puzzle: Puzzle

	var body: some View {
		VStack {
			Text("Day \(puzzle.id)")
				.font(.system(size: 24, weight: .semibold))

			Group {
				if puzzle.name.isEmpty {
					Text("Not revealed")
						.font(.system(size: 18)).italic()
						.foregroundColor(.secondary)
				} else {
					Text(puzzle.name)
						.font(.system(size: 24))
						.frame(height: 75)
				}
			}

			SolutionView(puzzle: puzzle, isA: true, isExample: true)

			SolutionView(puzzle: puzzle, isA: true, isExample: false)

			SolutionView(puzzle: puzzle, isA: false, isExample: true)

			SolutionView(puzzle: puzzle, isA: false, isExample: false)
		}
		.padding()
		.background(Color(backgroundColor).opacity(0.5))
		.border(.black)
		.cornerRadius(10)
		.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3))
	}

	var backgroundColor: UIColor {
		if puzzle.name.isEmpty {
			return .systemGray
		}
		switch puzzle.state {
		case .unsolved:
			return .systemRed
		case .solvedA:
			return .systemOrange
		case .solved:
			return .systemGreen
		}
	}
}

struct PuzzleCard_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			PuzzleCard(puzzle: PuzzlePreview.unsolved())
			PuzzleCard(puzzle: PuzzlePreview.partSolved())
			PuzzleCard(puzzle: PuzzlePreview.solved())
		}
		.frame(width: 300)
		.environmentObject(PuzzleProcessing(puzzles: PuzzlePreview().puzzles))
	}
}
