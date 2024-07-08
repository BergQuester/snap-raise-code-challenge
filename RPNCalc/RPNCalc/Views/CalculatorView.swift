//
//  ContentView.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import SwiftUI

// MARK: - View main body
struct CalculatorView: View {

    @State var viewModel = ViewModel()

    var body: some View {

        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()

            VStack {
                // Output
                TextEditor(text: $viewModel.display)
                    .disabled(true)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .padding()

                // Keypad
                VStack {
                    HStack {
                        button(withTitle: "C", color: Color(UIColor.darkGray), action: { viewModel.clear() })
                        button(withTitle: "SP", color: Color(UIColor.darkGray), action: { viewModel.addSpace() })
                        button(withTitle: "-", color: Color(UIColor.darkGray), action: { viewModel.add(digit: "-") })
                        button(withTitle: "/", color: .orange, action: { viewModel.add(operation: "/") })
                    }
                    HStack {
                        button(withTitle: "7", color: .gray, action: { viewModel.add(digit: "7") })
                        button(withTitle: "8", color: .gray, action: { viewModel.add(digit: "8") })
                        button(withTitle: "9", color: .gray, action: { viewModel.add(digit: "9") })
                        button(withTitle: "*", color: .orange, action: { viewModel.add(operation: "*") })
                    }
                    HStack {
                        button(withTitle: "4", color: .gray, action: { viewModel.add(digit: "4") })
                        button(withTitle: "5", color: .gray, action: { viewModel.add(digit: "5") })
                        button(withTitle: "6", color: .gray, action: { viewModel.add(digit: "6") })
                        button(withTitle: "-", color: .orange, action: { viewModel.add(operation: "-") })
                    }
                    HStack {
                        button(withTitle: "1", color: .gray, action: { viewModel.add(digit: "1") })
                        button(withTitle: "2", color: .gray, action: { viewModel.add(digit: "2") })
                        button(withTitle: "3", color: .gray, action: { viewModel.add(digit: "3") })
                        button(withTitle: "+", color: .orange, action: { viewModel.add(operation: "+") })
                    }
                    HStack {
                        button(withTitle: "0", color: .gray, action: { viewModel.add(operation: "0") })
                        button(withTitle: ".", color: .gray, action: { viewModel.add(digit: ".") })
                        button(withTitle: "Enter", color: .orange, action: { viewModel.performCalculation() })
                    }
                }
            }
        }
    }
}

// MARK: - Helper Methods
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

// MARK: - ViewModel
extension CalculatorView {
    @Observable
    class ViewModel {

        var calculator = Calculator()
        var history = ""
        var currentInput = ""

        var display: String {
            get {
                history + "\n" + Self.prompt + " " + currentInput + Self.cursor
            }
            set { } // Do nothing. Needed as `TextEditor` requires two-way binding
                    // even though the view is set to read-only
        }

        static let prompt = ">"
        static let cursor = "_"
        static var nonNumericCharacters = {
            var nonNumeric = NSMutableCharacterSet.decimalDigits
            nonNumeric.insert(charactersIn: "-.")
            nonNumeric.invert()
            return nonNumeric
        }()

        func add(digit: String) {
            // If the last item on the input is not part of a numerical value
            // add a space
            if let lastToken = currentInput.split(separator: " ").last,
               lastToken.rangeOfCharacter(from: Self.nonNumericCharacters) != nil {
                currentInput += " "
            }

            currentInput += digit
        }

        func add(operation: String) {
            currentInput += " " + operation + " "
        }

        func addSpace() {
            currentInput += " "
        }

        func clear() {
            if currentInput.isEmpty {
                history = ""
            } else {
                currentInput = ""
            }
        }

        func performCalculation() {
            guard !currentInput.isEmpty else { return }

            do {
                let result = try calculator.evaluate(string: currentInput)
                history += "\n" + Self.prompt + " " + currentInput
                history += "\n" + String(result)
                currentInput = ""
            } catch {
                history += "\nPlease check your equation for correct RPN formatting"
            }
        }
    }
}

#Preview {
    CalculatorView()
}
