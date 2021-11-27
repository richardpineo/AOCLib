
import Foundation
import CryptoKit

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

	var md5: String {
		return md5Data.map {
			String(format: "%02hhx", $0)
		}.joined()
	}
	
	var md5Data: Insecure.MD5.Digest {
		return Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
	}
}
