
import CryptoKit
import Foundation

public extension String {
	func character(at: Int) -> Character {
		self[index(startIndex, offsetBy: at)]
	}

	func assignCharacter(at index: Int, with newChar: Character) -> String {
		var chars = Array(self)
		chars[index] = newChar
		return String(chars)
	}

	func subString(start: Int, count: Int) -> String {
		let startPos = index(startIndex, offsetBy: start)
		let endPos = index(startIndex, offsetBy: start + count)
		return String(self[startPos ..< endPos])
	}

	func pad(toSize: Int) -> String {
		var padded = self
		for _ in 0 ..< (toSize - count) {
			padded = "0" + padded
		}
		return padded
	}

	func binaryToNumber() -> UInt64 {
		UInt64(self, radix: 2)!
	}

	init(fromBinary value: UInt64) {
		let ass = String(value, radix: 2)
		self = ass.pad(toSize: 36)
	}

	func hexToBinary() -> String {
		var result = ""
		forEach {
			let bin = String(Int(String($0), radix: 16)!, radix: 2)
			result.append(bin.pad(toSize: 4))
		}
		return result
	}

	var md5: String {
		md5Data.map {
			String(format: "%02hhx", $0)
		}.joined()
	}

	var md5Data: Insecure.MD5.Digest {
		Insecure.MD5.hash(data: data(using: .utf8) ?? Data())
	}

	// Case sensitive
	var isUnique: Bool {
		let sorted = String(sorted())
		for index in 1...sorted.count {
			if sorted.character(at: index) == sorted.character(at: index - 1) {
				return false
			}
		}
		return true
	}
}

public extension StringProtocol {
	func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
		range(of: string, options: options)?.lowerBound
	}

	func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
		range(of: string, options: options)?.upperBound
	}

	func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
		ranges(of: string, options: options).map(\.lowerBound)
	}

	func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
		var result: [Range<Index>] = []
		var startIndex = self.startIndex
		while startIndex < endIndex,
		      let range = self[startIndex...]
		      .range(of: string, options: options)
		{
			result.append(range)
			startIndex = range.lowerBound < range.upperBound ? range.upperBound :
				index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
		}
		return result
	}
}
