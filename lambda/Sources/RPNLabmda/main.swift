// The Swift Programming Language
// https://docs.swift.org/swift-book

import AWSLambdaRuntime

struct Input: Codable {
    let equation: String
}

struct Output: Codable {
    let result: String
}

Lambda.run { (context, input: Input, completion: @escaping (Result<Output, Error>) -> Void) in
    do {
        var calculator = Calculator()
        let result = try calculator.evaluate(string: input.equation)
        completion(.success(Output(result: "\(result)")))
    } catch {
        completion(.failure(error))
    }
}
