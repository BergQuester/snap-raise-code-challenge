//
//  EquationElementTests.swift
//  RPNCalcTests
//
//  Created by Daniel Bergquist on 7/8/24.
//

import XCTest
@testable import RPNCalc

final class EquationElementTests: XCTestCase {

    func testParsing() throws {
        let inputString = "1 2 3.141 4 -5 6 + - * /"
        let parsedElements = Array(fromRPNString: inputString)

        XCTAssertEqual(parsedElements, [.value(1),
                                        .value(2),
                                        .value(3.141),
                                        .value(4),
                                        .value(-5),
                                        .value(6),
                                        .operation(.addition),
                                        .operation(.subtraction),
                                        .operation(.multiplication),
                                        .operation(.division),
                                       ])
    }

    func testParsingFailure() {
        XCTAssertNil(Array(fromRPNString: "2/"))
        XCTAssertNil(Array(fromRPNString: "2 4 )"))
        XCTAssertNil(Array(fromRPNString: "1 2 3.141 4 -5a 6 + - * /"))
    }
}
