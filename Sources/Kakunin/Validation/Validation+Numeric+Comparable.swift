//
//  Validation+Numeric+Comparable.swift
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

public extension Validation where Value: Numeric & Comparable {
    
    /// Validate if the value is positive (`> 0`).
    /// - Parameter message: the error message
    static func positive(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value > 0
        }
    }
    
    /// Validate if the value is non-negative (`>= 0`).
    /// - Parameter message: the error message
    static func nonnegative(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value >= 0
        }
    }
    
    /// Validate if the value is negative (`< 0`).
    /// - Parameter message: the error message
    static func negative(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value < 0
        }
    }
    
    /// Validate if the value is non-positive (`<= 0`).
    /// - Parameter message: the error message
    static func nonpositive(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value <= 0
        }
    }
}
