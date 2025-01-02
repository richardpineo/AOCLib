
import SwiftUI

struct ControlCenter: View {
	@EnvironmentObject var processing: PuzzleProcessing

	var body: some View {
		HStack(spacing: 30) {
			Group {
				Button(action: {
					processing.clearAll()
				}) {
					Image(systemName: "clear")
					Text("Clear All")
				}

				Button(action: {
					Task {
						await processing.processAll()
					}
				}) {
					Image(systemName: "forward")
					Text("Run All")
				}
			}
			.padding()
			.foregroundColor(.white)
			.background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))

			Spacer()
		}
	}
}

struct ControlCenterf_Previews: PreviewProvider {
	static var previews: some View {
		ControlCenter()
			.frame(width: 400, height: 100)
	}
}
