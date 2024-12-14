

import SwiftUI

struct SolutionView: View {
	@EnvironmentObject var processing: PuzzleProcessing

	var puzzle: Puzzle
	var isA: Bool
	var isExample: Bool
	
	@State var processingStep: Int = 0
	@State private var isPulsing = false

	var body: some View {
		HStack {
			if(isExample) {
				Image(systemName: "testtube.2")
			}
			
			Spacer()

			if processing.isProcessing(processingId) {
				Text(elapsed)
			} else {
				if solution.isEmpty {
					Text("UNSOLVED")
				} else {
					Text(shortenIfNeeded(solution))
						.lineLimit(1)
						.minimumScaleFactor(0.5)
				}
			}

			Spacer()

			PuzzleProcessingView(processingStep: processingStep, processingId: PuzzleProcessingId(id: puzzle.id, isA: isA, isExample: isExample))
		}
		.padding(.vertical, 4)
		.padding(.horizontal, 5)
		.frame(maxWidth: .infinity)
		.contentShape(Rectangle())
		.onTapGesture {
			if solution.isEmpty || processing.isProcessing(processingId) {
				return
			}
			UIPasteboard.general.string = solution
			pulsateText()
		}
		.background(backgroundColor
			.opacity(isPulsing ? 1 : 0.5)
		)
		.cornerRadius(10)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.black, lineWidth: 2))
		.onReceive(timer) { _ in
			self.processingStep = self.processingStep + 1
		}
	}

	private var solution: String {
		isA ? puzzle.solutionA : puzzle.solutionB
	}

	private var backgroundColor: Color {
		isPulsing ? Color.accentColor : Color.gray
	}

	private func pulsateText() {
		isPulsing = true
		withAnimation(Animation.easeInOut) {
			isPulsing = false
		}
	}

	private func shortenIfNeeded(_ solution: String) -> String {
		let max = 20
		return solution.count > max ? "Too Long" : solution
	}

	private static let updateHz = 0.1
	private let timer = Timer.publish(every: updateHz, on: .main, in: .common).autoconnect()

	private var elapsed: String {
		guard let elapsed = processing.elapsed(processingId) else {
			return ""
		}
		let sec = elapsed.magnitude
		if sec < 3 {
			let rounded = lround(sec * 1000)
			return "\(rounded) ms"
		} else {
			let rounded = Double(lround(sec * 10)) / 10.0
			return "\(rounded) sec"
		}
	}

	private var processingId: PuzzleProcessingId {
		PuzzleProcessingId(id: puzzle.id, isA: isA, isExample: isExample)
	}
}

struct Solutionview_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Group {
				SolutionView(puzzle: PuzzlePreview.unsolved(), isA: true, isExample: true)
				SolutionView(puzzle: PuzzlePreview.solved(), isA: true, isExample: false)
				SolutionView(puzzle: PuzzlePreview.partSolved(), isA: true, isExample: true)
				SolutionView(puzzle: PuzzlePreview.partSolved(), isA: false, isExample: false)
			}
			.frame(width: 200, height: 100)
		}
		.environmentObject(PuzzlePreview().processing())
	}
}
