//
//  Stack.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import Foundation

/// A simple generic implementation of a stack
struct Stack<Element: Equatable>: Equatable {
    private var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        items.popLast()
    }

    func peek() -> Element? {
        items.last
    }

    mutating func clear() {
        items.removeAll()
    }
}
