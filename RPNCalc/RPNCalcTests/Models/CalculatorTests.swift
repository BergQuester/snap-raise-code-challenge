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
        XCTAssertEqual(try? calculator.evaluate(string: "5 5 5 8 + + -"), -13.0)
        XCTAssertEqual(try? calculator.evaluate(string: "13 +"), 0.0)
    }

    func testNegativesWithMultiplicationAndAddition() {
        XCTAssertEqual(try? calculator.evaluate(string: "-3"), -3.0)
        XCTAssertEqual(try? calculator.evaluate(string: "-2"), -2.0)
        XCTAssertEqual(try? calculator.evaluate(string: "*"), 6.0)
        XCTAssertEqual(try? calculator.evaluate(string: "5"), 5)
        XCTAssertEqual(try? calculator.evaluate(string: "+"), 11.0)
    }

    func testDivisionAndSubtraction() {
        XCTAssertEqual(try? calculator.evaluate(string: "5"), 5.0)
        XCTAssertEqual(try? calculator.evaluate(string: "9"), 9)
        XCTAssertEqual(try? calculator.evaluate(string: "1"), 1)
        XCTAssertEqual(try? calculator.evaluate(string: "-"), 8)
        XCTAssertEqual(try? calculator.evaluate(string: "/"), 0.625)
    }

    func testParseError() {
        XCTAssertThrowsError(try calculator.evaluate(string: "the quick brown fox")) { error in
            XCTAssertEqual(error as! Calculator.CalculatorError, Calculator.CalculatorError.parsingError)
        }
    }

    func testOperandError() {
        XCTAssertThrowsError(try calculator.evaluate(string: "1 /")) { error in
            XCTAssertEqual(error as! Calculator.CalculatorError, Calculator.CalculatorError.notEnoughOperands)
        }
        XCTAssertThrowsError(try calculator.evaluate(string: "+")){ error in
            XCTAssertEqual(error as! Calculator.CalculatorError, Calculator.CalculatorError.notEnoughOperands)
        }
    }
}
