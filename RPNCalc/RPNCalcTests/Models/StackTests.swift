//
//  StackTests.swift
//  RPNCalcTests
//
//  Created by Daniel Bergquist on 7/13/24.
//

import XCTest
@testable import RPNCalc

final class StackTests: XCTestCase {

    func testPeek() throws {
        var stack = Stack<String>()
        XCTAssertNil(stack.peek())

        stack.push("A")
        XCTAssertEqual(stack.peek(), "A")

        stack.push("B")
        XCTAssertEqual(stack.peek(), "B")

        stack.push("C")
        XCTAssertEqual(stack.peek(), "C")
    }

    func testPop() throws {
        var stack = Stack<String>()
        XCTAssertNil(stack.pop())
        XCTAssertNil(stack.peek())

        stack.push("A")
        stack.push("B")
        stack.push("C")

        XCTAssertEqual(stack.pop(), "C")
        XCTAssertEqual(stack.peek(), "B")

        XCTAssertEqual(stack.pop(), "B")
        XCTAssertEqual(stack.peek(), "A")

        XCTAssertEqual(stack.pop(), "A")
        XCTAssertNil(stack.peek())
        XCTAssertNil(stack.pop())
    }
}
