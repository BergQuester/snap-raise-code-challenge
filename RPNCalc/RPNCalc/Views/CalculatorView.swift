//
//  ContentView.swift
//  RPNCalc
//
//  Created by Daniel Bergquist on 7/8/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CalculatorFeature {

    @ObservableState
    struct State: Equatable {

        var calculator = Calculator()
        var history = ""
        var currentInput = ""

        var display: String { history + "\n" + Self.prompt + " " + currentInput + Self.cursor }

        static let prompt = ">"
        static let cursor = "_"
        static var nonNumericCharacters = {
            var nonNumeric = NSMutableCharacterSet.decimalDigits
            nonNumeric.insert(charactersIn: "-.")
            nonNumeric.invert()
            return nonNumeric
        }()
    }

    enum Action {
        case addDigit(String)
        case addOperation(String)
        case addSpace
        case clear
        case performCalulation
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .addDigit(digit):
                // If the last item on the input is not part of a numerical value
                // add a space
                if let lastToken = state.currentInput.split(separator: " ").last,
                   lastToken.rangeOfCharacter(from: State.nonNumericCharacters) != nil {
                    state.currentInput += " "
                }

                state.currentInput += digit
                return .none

            case let .addOperation(operation):
                state.currentInput += " " + operation
                return .none

            case .addSpace:
                state.currentInput += " "
                return .none

            case .clear:
                if state.currentInput.isEmpty {
                    state.history = ""
                } else {
                    state.currentInput = ""
                }
                return .none

            case .performCalulation:
                guard !state.currentInput.isEmpty else { return .none }

                do {
                    let result = try state.calculator.evaluate(string: state.currentInput)
                    state.history += "\n" + State.prompt + " " + state.currentInput
                    state.history += "\n" + String(result)
                    state.currentInput = ""
                } catch {
                    state.history += "\nPlease check your equation for correct RPN formatting"
                }
                return .none
            }
        }
    }
}

// MARK: - View main body
struct CalculatorView: View {

    let store: StoreOf<CalculatorFeature>

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
                    Text(store.display)
                        .font(.system(size: 24, weight: .medium))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .foregroundStyle(.white)
                    Spacer()
                        .id("bottom")
                }
                .onChange(of: store.display) {
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
                button(withTitle: "C", color: Color(UIColor.darkGray), action: { store.send(.clear) })
                button(withTitle: "-", color: Color(UIColor.darkGray), action: { store.send(.addDigit("-")) })
                Spacer()
                    .frame(width: buttonSize, height: buttonSize)
                button(withTitle: "/", color: .orange, action: { store.send(.addOperation("/")) })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "7", color: .gray, action: { store.send(.addDigit("7")) })
                button(withTitle: "8", color: .gray, action: { store.send(.addDigit("8")) })
                button(withTitle: "9", color: .gray, action: { store.send(.addDigit("9")) })
                button(withTitle: "*", color: .orange, action: { store.send(.addOperation("*")) })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "4", color: .gray, action: { store.send(.addDigit("4")) })
                button(withTitle: "5", color: .gray, action: { store.send(.addDigit("5")) })
                button(withTitle: "6", color: .gray, action: { store.send(.addDigit("6")) })
                button(withTitle: "-", color: .orange, action: { store.send(.addOperation("-")) })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "1", color: .gray, action: { store.send(.addDigit("1")) })
                button(withTitle: "2", color: .gray, action: { store.send(.addDigit("2")) })
                button(withTitle: "3", color: .gray, action: { store.send(.addDigit("3")) })
                button(withTitle: "+", color: .orange, action: { store.send(.addOperation("+")) })
            }
            HStack(spacing: buttonSpacing) {
                button(withTitle: "0", color: .gray, action: { store.send(.addDigit("0")) })
                button(withTitle: "_", color: Color(UIColor.darkGray), action: { store.send(.addSpace) })
                button(withTitle: ".", color: .gray, action: { store.send(.addDigit(".")) })
                button(withTitle: "↵", color: .orange, action: { store.send(.performCalulation) })

            }
        }
    }
}

#Preview {
    CalculatorView(store: Store(initialState: CalculatorFeature.State()) {
        CalculatorFeature()
        }
    )
}
