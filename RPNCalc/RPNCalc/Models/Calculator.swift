//
//  Calculator.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import Foundation

struct Calculator {
    private var stack: Stack<EquationElement> = Stack()

    enum CalculatorError: Error {
        case notEnoughOperands
    }

    mutating func evaluate(string inputString: String) -> Double? {
        guard let equation = Array(fromRPNString: inputString) else {
            return nil
        }

        let originalStack = stack

        do {
            for element in equation {
                try evaluate(element)
            }
        } catch {
            stack = originalStack
            // TODO: Log error
        }

        guard case let .value(calculatedValue) = stack.peek() else {
            return nil
        }
        return calculatedValue
    }

    private mutating func evaluate(_ element: EquationElement) throws {
        switch element {
        case .value: stack.push(element)
        case let .operation(operation):
            guard case let .value(b) = stack.pop(),
                  case let .value(a) = stack.pop() else {
                throw CalculatorError.notEnoughOperands
            }

            let result = try operation.apply(a, b)
            stack.push(.value(result))
        }
    }
}
