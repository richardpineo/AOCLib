
import Foundation

public enum MathHelper {
	// https://codereview.stackexchange.com/questions/166324/prime-factorisation-in-swift
	public static func primeFactors(_ n: Int) -> [Int] {
		var n = n
		var factors: [Int] = []

		var divisor = 2
		while divisor * divisor <= n {
			while n % divisor == 0 {
				factors.append(divisor)
				n /= divisor
			}
			divisor += divisor == 2 ? 1 : 2
		}
		if n > 1 {
			factors.append(n)
		}

		return factors
	}

	// Stolen and ported from c# example here: https://www.geeksforgeeks.org/lcm-of-given-array-elements/
	public static func lcm(of elements: [Int]) -> Int64 {
		var element_array = elements.map { Int64($0) }
		var lcm_of_array_elements: Int64 = 1
		var divisor: Int64 = 2

		while true {
			var counter = 0
			var divisible = false
			for i in 0 ..< element_array.count {
				// lcm_of_array_elements (n1, n2, ... 0) = 0.
				// For negative number we convert into
				// positive and calculate lcm_of_array_elements.
				if element_array[i] == 0 {
					return 0
				} else if element_array[i] < 0 {
					element_array[i] = element_array[i] * -1
				}
				if element_array[i] == 1 {
					counter += 1
				}

				// Divide element_array by devisor if complete
				// division i.e. without remainder then replace
				// number with quotient; used for find next factor
				if element_array[i] % divisor == UInt64(0) {
					divisible = true
					element_array[i] = element_array[i] / divisor
				}
			}

			// If divisor able to completely divide any number
			// from array multiply with lcm_of_array_elements
			// and store into lcm_of_array_elements and continue
			// to same divisor for next factor finding.
			// else increment divisor
			if divisible {
				lcm_of_array_elements = lcm_of_array_elements * divisor
			} else {
				divisor += 1
			}

			// Check if all element_array is 1 indicate
			// we found all factors and terminate while loop.
			if counter == element_array.count {
				return lcm_of_array_elements
			}
		}
	}

	// greatest common denominator
	public func gcd(a: Int, b: Int) -> Int {
		if b == 0 { return a }
		return gcd(a: b, b: a % b)
	}

	// slope between two points, reduced to the most simplified rise and run
	public func reducedSlope(_ point1: Position2D, _ point2: Position2D) -> Position2D {
		let numerator = point2.y - point1.y
		let denominator = point2.x - point1.x
		let gcd = gcd(a: numerator, b: denominator)
		return .init(numerator / gcd, denominator / gcd)
	}
}
