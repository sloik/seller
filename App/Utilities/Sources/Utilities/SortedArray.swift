
import Foundation

// Grabbed from:
// https://github.com/objcio/S01E55-sorted-arrays-with-binary-search/blob/master/SortedArray.playground/Contents.swift
// until Swift Collection will not add sorted types.
public struct SortedArray<Element: Comparable> {
    var elements: [Element]

    public init<S: Sequence>(unsorted: S) where S.Iterator.Element == Element {
        elements = unsorted.sorted()
    }

    public func index(for element: Element) -> Int {
        var start = elements.startIndex
        var end = elements.endIndex
        while start < end {
            let middle = start + (end - start) / 2
            if elements[middle] < element {
                start = middle + 1
            } else {
                end = middle
            }
        }
        assert(start == end)
        return start
    }

    public mutating func insert(_ element: Element) {
        elements.insert(element, at: index(for: element))
    }

    public func contains(element: Element) -> Bool {
        let index = self.index(for: element)
        guard index < elements.endIndex else { return false }
        return self[index] == element
    }
}

extension SortedArray: Collection {
    public var startIndex: Int {
        elements.startIndex
    }

    public var endIndex: Int {
        elements.endIndex
    }

    var min: Element? {
        elements.first
    }

    public subscript(index: Int) -> Element {
        elements[index]
    }

    public func index(after i: Int) -> Int {
        elements.index(after: i)
    }
}

extension SortedArray: RandomAccessCollection {
    public func index(before i: Int) -> Int {
        elements.index(before: i)
    }
}
