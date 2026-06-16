//
//  Validation+Collection.swift
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

public extension Validation where Value: Collection {
    
    /// Validate if the value is empty.
    /// - Parameter message: the error message
    static func empty(message: any StringProtocol) -> Self {
        count(0, message: message)
    }
    
    /// Validate if the value is **not** empty.
    /// - Parameter message: the error message
    static func nonempty(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            !value.isEmpty
        }
    }
    
    /// Validate if the value contains at least a specified number of elements.
    /// - Parameters:
    ///   - minimum: the minimum required number of elements
    ///   - message: the error message
    static func minCount(_ minimum: Int,
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.count >= minimum
        }
    }
    
    /// Validate if the value contains no more than a specified number of elements.
    /// - Parameters:
    ///   - maximum: the maximum required number of elements
    ///   - message: the error message
    static func maxCount(_ maximum: Int,
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.count <= maximum
        }
    }
    
    /// Validate if the value contains a specific number of elements.
    /// - Parameters:
    ///   - number: The exact number of elements expected
    ///   - message: the error message
    static func count(_ number: Int,
                      message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.count == number
        }
    }
    
    /// Validate if the number of elements in the value falls within a specified range.
    /// - Parameters:
    ///   - range: a closed range specifying the valid number of elements
    ///   - message: the error message
    static func countRange(_ range: ClosedRange<Int>,
                           message: any StringProtocol) -> Self {
        .init(message: message) { value in
            range.contains(value.count)
        }
    }
}
