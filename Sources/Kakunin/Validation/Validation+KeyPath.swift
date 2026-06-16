//
//  Validation+KeyPath.swift
//
//  Copyright (c) 2026 Mathieu Nivelles (https://github.com/mnivelles)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


import Foundation

public extension Validation {
    
    /// Validate a value at a specific key path using another ``Validation`
    ///
    /// How to use:
    /// ```swift
    /// struct User {
    ///    var age: Int
    /// }
    ///
    /// @Validate(.keyPath(\User.age,
    ///                    Validation.min(18,
    ///                                   message: "Age must be 18 or older."),
    ///                    message: "Invalid user age."))
    /// var user = User(age: 20)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: a key path to a specific property of the value
    ///   - validation: a ``Validation`` that will be applied to the value at the key path
    ///   - message: the error message
    static func keyPath<T>(_ keyPath: @autoclosure @escaping () -> KeyPath<Value, T>,
                           _ validation: @autoclosure @escaping () -> Validation<T>,
                           message: any StringProtocol) -> Self {
        .init(message: message) { value in
            validation().validate(value[keyPath: keyPath()])
        }
    }
    
    /// Validate if a `Bool` property at a specific key path of the value is `true`.
    ///
    /// How to use:
    /// ```swift
    /// struct User {
    ///   var isActive: Bool
    /// }
    ///
    /// @Validate(.keyPath(\.isActive, message: "User must be active."))
    /// var user = User(isActive: true)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: a key path to a Bool property of the value
    ///   - message: the error message
    static func keyPath(_ keyPath: @autoclosure @escaping () -> KeyPath<Value, Bool>,
                        message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value[keyPath: keyPath()]
        }
    }
}
