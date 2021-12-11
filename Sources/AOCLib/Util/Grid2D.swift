
import Foundation

public struct Grid2D {
	public init(fileName: String) {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		self.init(intValues: values)
	}
	
	public init(intValues: [String]) {
		maxPos = .init(intValues[0].count, intValues.count)
		values = []
		intValues.forEach {
			$0.forEach {
				values.append(Int(String($0))!)
			}
		}
	}

	public var maxPos: Position2D

	public func valid(_ pos: Position2D) -> Bool {
		pos.x >= 0 && pos.y >= 0 && pos.x < maxPos.x && pos.y < maxPos.y
	}

	public func value(_ pos: Position2D) -> Int {
		values[pos.arrayIndex(numCols: maxPos.x)]
	}
	
	public mutating func setValue(_ pos: Position2D, _ i: Int) {
		values[pos.arrayIndex(numCols: maxPos.x)] = i
	}
	
	public func neighbors(_ pos: Position2D, includePos: Bool) -> [Position2D] {
		pos.neighbors(includeSelf: includePos)
			.filter { $0.cityDistance(pos) < 2 }
			.filter { valid($0) }
	}

	private var values: [Int]
}
