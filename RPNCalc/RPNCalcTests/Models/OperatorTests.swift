//
//  OperatorTests.swift
//  RPNCalcTests
//
//  Created by Daniel Bergquist on 7/13/24.
//

import XCTest
@testable import RPNCalc

final class OperatorTests: XCTestCase {
    func testFromSymbol() throws {
        XCTAssertEqual(Operator(fromSymbol: "+"), .addition)
        XCTAssertEqual(Operator(fromSymbol: "-"), .subtraction)
        XCTAssertEqual(Operator(fromSymbol: "*"), .multiplication)
        XCTAssertEqual(Operator(fromSymbol: "/"), .division)
        XCTAssertNil(Operator(fromSymbol: "A"))
    }

    func testApply_addition() throws {
        XCTAssertEqual(try Operator.addition.apply(1, -4.5), -3.5)
    }

    func testApply_subtraction() throws {
        XCTAssertEqual(try Operator.subtraction.apply(1, -4.5), 5.5)
    }

    func testApply_multiplication() throws {
        XCTAssertEqual(try Operator.multiplication.apply(1, -4.5), -4.5)
    }

    func testApply_division() throws {
        XCTAssertEqual(try Operator.division.apply(1, -4.5), -0.2222222222222222)
    }

    func testApply_divisionOfZero() throws {
        XCTAssertEqual(try Operator.division.apply(0, -4.5), 0)
    }

    func testApply_divisionByZero() throws {
        XCTAssertThrowsError(try Operator.division.apply(1, 0)) {error in
            XCTAssertEqual(error as? Operator.OperatorError, Operator.OperatorError.divideByZero)
        }
    }}
