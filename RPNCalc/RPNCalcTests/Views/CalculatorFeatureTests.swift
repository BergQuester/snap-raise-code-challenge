//
//  CalculatorFeatureTests.swift
//  RPNCalcTests
//
//  Created by Daniel Bergquist on 7/8/24.
//

import XCTest
@testable import RPNCalc
import ComposableArchitecture

final class CalculatorFeatureTests: XCTestCase {

    var store: TestStore<CalculatorFeature.State, CalculatorFeature.Action>!

    @MainActor
    override func setUp() async throws {
        store = TestStore(initialState: CalculatorFeature.State()) {
            CalculatorFeature()
        }
        store.exhaustivity = .off
    }

    @MainActor
    func testInitialStat() async {
        XCTAssertEqual(store.state.display, "\n> _")
    }

    @MainActor
    func testAddDigits() async {
        await store.send(.addDigit("-"))
        await store.send(.addDigit("1"))
        await store.send(.addDigit("."))
        await store.send(.addDigit("2")) {
            $0.currentInput = "-1.2"
        }
    }

    @MainActor
    func testAddDigitsAfterOperator() async {
        await store.send(.addOperation("*"))
        await store.send(.addDigit("5"))
        await store.send(.addDigit("7"))
        await store.send(.addDigit("."))
        await store.send(.addDigit("7")) {
            $0.currentInput = " * 57.7"
        }
    }

    @MainActor
    func testAddOperation() async {
        await store.send(.addDigit("1"))
        await store.send(.addDigit("2"))
        await store.send(.addDigit(" "))
        await store.send(.addDigit("4"))
        await store.send(.addOperation("+")) {
            $0.currentInput = "12 4 +"
        }
    }

    @MainActor
    func testClear() async {
        await store.send(.addDigit("1"))
        await store.send(.addDigit("2"))
        await store.send(.addDigit(" "))
        await store.send(.addDigit("4"))
        await store.send(.addOperation("+"))

        await store.send(.performCalulation) {
            $0.history = "\n> 12 4 +\n16.0"
        }

        await store.send(.addDigit("2")) {
            $0.currentInput = "2"
        }

        await store.send(.clear) {
            $0.currentInput = ""
        }

        await store.send(.clear) {
            $0.history = ""
        }
    }

    @MainActor
    func testAddSpace() async {
        await store.send(.addDigit("1"))
        await store.send(.addSpace) {
            $0.currentInput = "1 "
        }
    }

    @MainActor
    func testPerformCalulation() async {
        await store.send(.addDigit("4"))
        await store.send(.addDigit("2"))
        await store.send(.addDigit(" "))
        await store.send(.addDigit("4"))
        await store.send(.addOperation("/"))

        await store.send(.performCalulation) {
            $0.history = "\n> 42 4 /\n10.5"
        }
    }
}
