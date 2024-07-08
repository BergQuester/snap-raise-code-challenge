//
//  EquationElement.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import Foundation

enum EquationElement: Equatable {
    case value(Double)
    case operation(Operator) // 'operator' is reserved by Swift

    init?(from string: Substring) {
        if let value = Double(string) {
            self = .value(value)
        } else if let operation = Operator(fromSymbol: string) {
            self = .operation(operation)
        } else {
            return nil
        }
    }
}

extension Array where Element == EquationElement {
    init?(fromRPNString RPNString: String) {
        let tokens = RPNString.split(separator: " ")
        let elements = tokens.compactMap(EquationElement.init(from:))

        // If the number of elements does not match the number
        // of input tokens, then something didn't parse correctly
        if elements.count != tokens.count {
            return nil
        }

        self = elements
    }
}
