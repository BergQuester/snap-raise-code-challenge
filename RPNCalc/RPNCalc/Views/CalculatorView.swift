//
//  ContentView.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import SwiftUI

struct CalculatorView: View {
    var body: some View {

        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()

            VStack {
                // Output
                TextEditor(text: /*@START_MENU_TOKEN@*/.constant("Placeholder")/*@END_MENU_TOKEN@*/)
                    .disabled(true)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .padding()

                // Keypad
                VStack {
                    HStack {
                        button(withTitle: "AC", color: Color(UIColor.darkGray), action: {})
                        button(withTitle: "<", color: Color(UIColor.darkGray), action: {})
                        button(withTitle: "", color: Color(UIColor.darkGray), action: {})
                        button(withTitle: "/", color: .orange, action: {})
                    }
                    HStack {
                        button(withTitle: "7", color: .gray, action: {})
                        button(withTitle: "8", color: .gray, action: {})
                        button(withTitle: "9", color: .gray, action: {})
                        button(withTitle: "*", color: .orange, action: {})
                    }
                    HStack {
                        button(withTitle: "4", color: .gray, action: {})
                        button(withTitle: "5", color: .gray, action: {})
                        button(withTitle: "6", color: .gray, action: {})
                        button(withTitle: "-", color: .orange, action: {})
                    }
                    HStack {
                        button(withTitle: "1", color: .gray, action: {})
                        button(withTitle: "2", color: .gray, action: {})
                        button(withTitle: "3", color: .gray, action: {})
                        button(withTitle: "+", color: .orange, action: {})
                    }
                    HStack {
                        button(withTitle: "0", color: .gray, action: {})
                        button(withTitle: ".", color: .gray, action: {})
                        button(withTitle: "Enter", color: .orange, action: {})
                    }
                }
            }
        }
    }
}

extension CalculatorView {
    func button(withTitle title: String,
                color: Color,
                action: @escaping () -> Void) -> some View {
        Button(action: action,
               label: {
            Text(title)
        })
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .tint(color)
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}


#Preview {
    CalculatorView()
}
