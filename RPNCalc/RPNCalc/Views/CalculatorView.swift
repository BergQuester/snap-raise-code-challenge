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

    let buttonSpacing: CGFloat = 5

    var body: some View {

        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()

            VStack {
                history()
                keypad()
            }
        }
    }
}

// MARK: - Helper Methods
extension CalculatorView {
    private var buttonSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let horizontalButtonCount: CGFloat = 4
        let spaceCount = horizontalButtonCount + 1
        return ((screenWidth - (spaceCount * buttonSpacing)) / horizontalButtonCount)
    }

    func button(withTitle title: String,
                color: Color,
                action: @escaping () -> Void) -> some View {

        Button(title, action: action)
            .buttonStyle(CalculatorButtonStyle(
                size: buttonSize,
                backgroundColor: color)
            )
    }

    func history() -> some View {
        ScrollView {
            ScrollViewReader { value in
                VStack(alignment: .leading) {
                    Text(viewModel.display)
                        .font(.system(size: 24, weight: .medium))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .foregroundStyle(.white)
                    Spacer()
                        .id("bottom")
                }
                .onChange(of: viewModel.display) {
                    value.scrollTo("bottom")
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func keypad() -> some View {
        // Keypad
        VStack(spacing: buttonSpacing) {
            HStack(spacing: buttonSpacing) {
                button(withTitle: "C", color: Color(UIColor.darkGray), action: { viewModel.clear() })
                button(withTitle: "-", color: Color(UIColor.darkGray), action: { viewModel.add(digit: "-") })
                Spacer()
                    .frame(width: buttonSize, height: buttonSize)
                button(withTitle: "/", color: .orange, action: { viewModel.add(operation: "/") })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "7", color: .gray, action: { viewModel.add(digit: "7") })
                button(withTitle: "8", color: .gray, action: { viewModel.add(digit: "8") })
                button(withTitle: "9", color: .gray, action: { viewModel.add(digit: "9") })
                button(withTitle: "*", color: .orange, action: { viewModel.add(operation: "*") })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "4", color: .gray, action: { viewModel.add(digit: "4") })
                button(withTitle: "5", color: .gray, action: { viewModel.add(digit: "5") })
                button(withTitle: "6", color: .gray, action: { viewModel.add(digit: "6") })
                button(withTitle: "-", color: .orange, action: { viewModel.add(operation: "-") })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "1", color: .gray, action: { viewModel.add(digit: "1") })
                button(withTitle: "2", color: .gray, action: { viewModel.add(digit: "2") })
                button(withTitle: "3", color: .gray, action: { viewModel.add(digit: "3") })
                button(withTitle: "+", color: .orange, action: { viewModel.add(operation: "+") })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "0", color: .gray, action: { viewModel.add(operation: "0") })
                button(withTitle: "_", color: Color(UIColor.darkGray), action: { viewModel.addSpace() })
                button(withTitle: ".", color: .gray, action: { viewModel.add(digit: ".") })
                button(withTitle: "↵", color: .orange, action: { viewModel.performCalculation() })

            }
        }
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
        }

        private static let prompt = ">"
        private static let cursor = "_"
        private static var nonNumericCharacters = {
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
            currentInput += " " + operation
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
