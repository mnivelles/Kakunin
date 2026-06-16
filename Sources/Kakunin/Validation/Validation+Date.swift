//
//  Validation+Date.swift
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

public extension Validation where Value == Date {
    
    /// Validate if the value is greater than or equal to a specified minimum date.
    /// - Parameters:
    ///   - number: the minimum date to compare against
    ///   - message: the error message
    static func min(_ number: @autoclosure @escaping () -> Value,
                    message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value >= number()
        }
    }
    
    /// Validate if the value is less than or equal to a specified maximum date.
    /// - Parameters:
    ///   - number: the maximum date to compare against
    ///   - message: the error message
    static func max(_ number: @autoclosure @escaping () -> Value,
                    message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value <= number()
        }
    }
    
    /// Validate if the value is within a specified closed range.
    /// - Parameters:
    ///   - closedRange: a closed range specifying the valid bounds
    ///   - message: the error message
    static func range(_ closedRange: @autoclosure @escaping () -> ClosedRange<Value>,
                      message: any StringProtocol) -> Self {
        .init(message: message) { value in
            closedRange().contains(value)
        }
    }
}
