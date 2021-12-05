

import Foundation

public enum Combinatorics {
	public static func permutations(_ a: [String]) -> [[String]] {
		var local = a
		var output = Set<[String]>()
		permutations(a.count, &local, &output)
		return Array(output)
	}

	// https://stackoverflow.com/questions/34968470/calculate-all-permutations-of-a-string-in-swift
	private static func permutations(_ n: Int, _ a: inout [String], _ out: inout Set<[String]>) {
		if n == 1 {
			// print(a);
			out.insert(a)
			return
		}
		for i in 0 ..< n - 1 {
			permutations(n - 1, &a, &out)
			a.swapAt(n - 1, (n % 2 == 1) ? 0 : i)
		}
		permutations(n - 1, &a, &out)
	}

	// Partitions a set of n values with m nonempty partitions.
	// so for n=4 and m=2 this would return [1,3] and [2,2] but it would not
	// return [3,1] because that is a duplicate.
	public static func partition(_ n: Int, _ m: Int) -> [[Int]] {
		var q = Queue<Int>()
		return partition(n, 1, m, &q)
	}

	private static func partition(_ n: Int, _ digitFrom: Int, _ m: Int, _ s: inout Queue<Int>) -> [[Int]] {
		let digitTo = n - m + 1
		if digitFrom > digitTo {
			return []
		}
		if m == 1 {
			var combo = s.array
			combo.append(n)
			return [combo]
		}
		var answers: [[Int]] = []
		for firstDigit in digitFrom ... digitTo {
			s.enqueue(firstDigit)
			let a = partition(n - firstDigit, firstDigit, m - 1, &s)
			answers.append(contentsOf: a)
			_ = s.dequeue()
		}

		return answers
	}
}
