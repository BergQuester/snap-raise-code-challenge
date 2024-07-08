# Overview

This is my solution to the Snap Raise RPN code challenge for iOS. The UI is implemented in SwiftUI, uses MVVM, and has unit test coverage and was implemented with Xcode 15.4

# Reasoning

SwiftUI is Apple's modern UI app framework. While SwiftUI is still [missing a few things](https://www.hackingwithswift.com/articles/270/whats-new-in-swiftui-for-ios-18) requiring developers to occasionally dip into UIKit, this code challenge did not use any such features and benefited from rapid feedback.

For the architecture, MVVM was used as this is the most common pattern in the iOS developer community today. The app could be quickly adapted to use an Action?State/Reducer architecture such as [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture?tab=readme-ov-file).

With a single developer and a single screen, this app was not large enough to benefit from app modularization.

# Considerations

With more time, this app could benefit from:

* UI/UX
    * More user-actionable errors
    * Smarter user entry of equations by making `CalculatorView.ViewModel.currentInput` an array of `EquationElement`s.
    * Better keypad layout
    * Better support for iPad screens.
* Technical
    * More consideration on Unit Tests.
    * UI tests

# Running the Code

Open `RPNCalc.xcodeproj` with Xcode 15.4 or later. Select a simulator or device and click the play button.