//
//  CalculatorViewModelTests.swift
//  RPNCalcTests
//
//  Created by Daniel Bergquist on 7/8/24.
//

import XCTest
@testable import RPNCalc

final class CalculatorViewModelTests: XCTestCase {

    let viewModel = CalculatorView.ViewModel()

    func testInitialStat() {
        XCTAssertEqual(viewModel.display, "\n> _")
    }

    func testAddDigits() {
        viewModel.add(digit: "-")
        viewModel.add(digit: "1")
        viewModel.add(digit: ".")
        viewModel.add(digit: "2")

        XCTAssertEqual(viewModel.display, "\n> -1.2_")
    }

    func testAddDigitsAfterOperator() {
        viewModel.add(operation: "*")
        viewModel.add(digit: "5")
        viewModel.add(digit: "7")
        viewModel.add(digit: ".")
        viewModel.add(digit: "7")

        XCTAssertEqual(viewModel.display, "\n>  * 57.7_")
    }

    func testAddOperator() {
        viewModel.add(digit: "1")
        viewModel.add(digit: "2")
        viewModel.add(digit: " ")
        viewModel.add(digit: "4")
        viewModel.add(operation: "+")

        XCTAssertEqual(viewModel.display, "\n> 12 4 +_")
    }

    func testClear() {
        viewModel.add(digit: "1")
        viewModel.add(digit: "2")
        viewModel.add(digit: " ")
        viewModel.add(digit: "4")
        viewModel.add(operation: "+")

        viewModel.performCalculation()

        viewModel.add(digit: "2")

        XCTAssertEqual(viewModel.display, "\n> 12 4 +\n16.0\n> 2_")

        viewModel.clear()

        XCTAssertEqual(viewModel.display, "\n> 12 4 +\n16.0\n> _")

        viewModel.clear()

        XCTAssertEqual(viewModel.display, "\n> _")
    }

    func testAddSpace() {
        viewModel.add(digit: "1")
        viewModel.addSpace()

        XCTAssertEqual(viewModel.display, "\n> 1 _")
    }

    func testPerformCalulation() {
        viewModel.add(digit: "4")
        viewModel.add(digit: "2")
        viewModel.add(digit: " ")
        viewModel.add(digit: "4")
        viewModel.add(operation: "/")

        viewModel.performCalculation()

        XCTAssertEqual(viewModel.display, "\n> 42 4 /\n10.5\n> _")

    }
}
