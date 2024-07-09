//
//  RPNCalcApp.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct RPNCalcApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView(store: Store(initialState: CalculatorFeature.State()) {
                CalculatorFeature()
            }
            )
        }
    }
}
