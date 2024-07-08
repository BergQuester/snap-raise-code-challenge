//
//  Operator.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import Foundation

enum Operator {
    case addition
    case subtraction
    case multiplication
    case division

    enum OperatorError: Error {
        case divideByZero
    }

    init?(fromSymbol symbol: String) {
        switch symbol {
        case "+": self = .addition
        case "-": self = .subtraction
        case "*": self = .multiplication
        case "/": self = .division
        default: return nil
        }
    }

    var symbol: String {
        switch self {
        case .addition: "+"
        case .subtraction: "-"
        case .multiplication: "*"
        case .division: "/"
        }
    }

    func apply(_ a: Double , _ b: Double) throws -> Double {
        switch self {
        case .addition: return a + b
        case .subtraction: return a - b
        case .multiplication: return a * b
        case .division:
            guard b != 0.0 else {
                throw OperatorError.divideByZero
            }
            return a / b
        }
    }
}
