
import Foundation

public struct Queue<T> {
	private var list = [T]()

	public init() {
		list = [T]()
	}

	public init(from: [T]) {
		list = from
	}

	public var isEmpty: Bool {
		list.isEmpty
	}

	public mutating func enqueue(_ element: T) {
		list.append(element)
	}

	public mutating func dequeue() -> T? {
		if !list.isEmpty {
			return list.removeFirst()
		} else {
			return nil
		}
	}

	public func peek() -> T? {
		if !list.isEmpty {
			return list[0]
		} else {
			return nil
		}
	}

	public var count: Int {
		list.count
	}

	public var array: [T] {
		list
	}
}
