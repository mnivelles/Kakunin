//
//  Validation+Operator.swift
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

public extension Validation {
    
    /// Combines two `Validation` using a logical OR.
    ///
    /// The resulting validation will pass if either of the individual validations pass.
    ///
    /// - Parameters:
    ///   - lhs: the first validation to combine
    ///   - rhs: the second validation to combine
    static func || (lhs: Self,
                    rhs: @autoclosure @escaping () -> Self) -> Self {
        Self(messages: lhs.messages + rhs().messages,
             predicate: {
            lhs.validate($0) || rhs().validate($0)
        })
    }
}

public extension Validation {
    
    /// Negates the result of a `Validation`.
    ///
    /// The resulting validation will pass if the original validation fails and vice versa.
    ///
    /// - Parameter validation: The `Validation` to negate
    static prefix func ! (validation: Self) -> Self {
        Self(messages: validation.messages,
             predicate: { !validation.validate($0) })
    }
}
