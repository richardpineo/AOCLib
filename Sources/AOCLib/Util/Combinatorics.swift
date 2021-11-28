

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
}
