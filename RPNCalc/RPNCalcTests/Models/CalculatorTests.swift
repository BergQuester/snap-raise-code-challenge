//
//  CalculatorTests.swift
//  RPNCalcTests
//
//  Created by Daniel Bergquist on 7/8/24.
//

import XCTest
@testable import RPNCalc

final class CalculatorTests: XCTestCase {

    var calculator = Calculator()

    func testLongEquationWithAdditionalTerms() {
        XCTAssertEqual(calculator.evaluate(string: "5 5 5 8 + + -"), -13.0)
        XCTAssertEqual(calculator.evaluate(string: "13 +"), 0.0)
    }

    func testNegativesWithMultiplicationAndAddition() {
        XCTAssertEqual(calculator.evaluate(string: "-3"), -3.0)
        XCTAssertEqual(calculator.evaluate(string: "-2"), -2.0)
        XCTAssertEqual(calculator.evaluate(string: "*"), 6.0)
        XCTAssertEqual(calculator.evaluate(string: "5"), 5)
        XCTAssertEqual(calculator.evaluate(string: "+"), 11.0)
    }

    func testDivisionAndSubtraction() {
        XCTAssertEqual(calculator.evaluate(string: "5"), 5.0)
        XCTAssertEqual(calculator.evaluate(string: "9"), 9)
        XCTAssertEqual(calculator.evaluate(string: "1"), 1)
        XCTAssertEqual(calculator.evaluate(string: "-"), 8)
        XCTAssertEqual(calculator.evaluate(string: "/"), 0.625)
    }
}
