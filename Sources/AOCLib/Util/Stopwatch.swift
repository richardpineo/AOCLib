import CoreFoundation

// let timer = Stopwatch()
// ... a long runnig task ...
// "The task took \(timer.stop()) seconds."
public class Stopwatch {
	private let startTime: CFAbsoluteTime
	private var endTime: CFAbsoluteTime?

	public init() {
		startTime = CFAbsoluteTimeGetCurrent()
	}

	public var elapsed: String {
		let el = CFAbsoluteTimeGetCurrent() - startTime
		let sec = el.magnitude
		if sec < 1 {
			let rounded = lround(sec * 1000)
			return "\(rounded) ms"
		} else {
			let rounded = Double(lround(sec * 10)) / 10.0
			return "\(rounded) sec"
		}
	}

	public func stop() -> CFAbsoluteTime {
		endTime = CFAbsoluteTimeGetCurrent()
		return endTime! - startTime
	}
}
